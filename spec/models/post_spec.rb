require 'rails_helper'

describe Post do
  let(:member) { FactoryGirl.create(:member) }

  it_behaves_like "it is likeable"

  it "should be sorted in reverse order" do
    FactoryGirl.create(:post,
      subject: 'first entry',
      author: member,
      created_at: 2.days.ago)
    FactoryGirl.create(:post,
      subject: 'second entry',
      author: member,
      created_at: 1.day.ago)
    Post.first.subject.should == "second entry"
  end

  it "should have a slug" do
    post = FactoryGirl.create(:post, author: member)
    time = post.created_at
    datestr = time.strftime("%Y%m%d")
    # 2 digit day and month, full-length years
    # Counting digits using Math.log is not precise enough!
    datestr.size.should eq(4 + time.year.to_s.size)
    post.slug.should eq("#{member.login_name}-#{datestr}-a-post")
  end

  it "has many comments" do
    post = FactoryGirl.create(:post, author: member)
    FactoryGirl.create(:comment, post: post)
    FactoryGirl.create(:comment, post: post)
    post.comments.size.should == 2
  end

  it "supports counting comments" do
    post = FactoryGirl.create(:post, author: member)
    FactoryGirl.create(:comment, post: post)
    FactoryGirl.create(:comment, post: post)
    post.comment_count.should == 2
  end

  it "destroys comments when deleted" do
    post = FactoryGirl.create(:post, author: member)
    FactoryGirl.create(:comment, post: post)
    FactoryGirl.create(:comment, post: post)
    post.comments.size.should eq(2)
    all = Comment.count
    post.destroy
    Comment.count.should eq(all - 2)
  end

  it "belongs to a forum" do
    post = FactoryGirl.create(:forum_post)
    post.forum.should be_an_instance_of Forum
  end

  it "doesn't allow a nil subject" do
    post = FactoryGirl.build(:post, subject: nil)
    post.should_not be_valid
  end

  it "doesn't allow a blank subject" do
    post = FactoryGirl.build(:post, subject: "")
    post.should_not be_valid
  end

  it "doesn't allow a subject with only spaces" do
    post = FactoryGirl.build(:post, subject: "    ")
    post.should_not be_valid
  end

  context "recent activity" do
    before do
      Time.stub(now: Time.now)
    end

    let!(:post) { FactoryGirl.create(:post, created_at: 1.day.ago) }

    it "sets recent activity to post time" do
      post.recent_activity.to_i.should eq post.created_at.to_i
    end

    it "sets recent activity to comment time" do
      comment = FactoryGirl.create(:comment, post: post,
                                             created_at: 1.hour.ago)
      post.recent_activity.to_i.should eq comment.created_at.to_i
    end

    it "shiny new post is recently active" do
      # create a shiny new post
      post2 = FactoryGirl.create(:post, created_at: 1.minute.ago)
      Post.recently_active.first.should eq post2
      Post.recently_active.second.should eq post
    end

    it "new comment on old post is recently active" do
      # now comment on an older post
      post2 = FactoryGirl.create(:post, created_at: 1.minute.ago)
      FactoryGirl.create(:comment, post: post, created_at: 1.second.ago)
      Post.recently_active.first.should eq post
      Post.recently_active.second.should eq post2
    end
  end

  context "notifications" do
    let(:member2) { FactoryGirl.create(:member) }

    it "sends a notification when a member is mentioned using @-syntax" do
      expect do
        FactoryGirl.create(:post, author: member, body: "Hey @#{member2}")
      end.to change(Notification, :count).by(1)
    end

    it "sends a notification when a member is mentioned using [](member) syntax" do
      expect do
        FactoryGirl.create(:post, author: member, body: "Hey [#{member2}](member)")
      end.to change(Notification, :count).by(1)
    end

    it "sets the notification field" do
      p = FactoryGirl.create(:post, author: member, body: "Hey @#{member2}")
      n = Notification.first
      n.sender.should eq member
      n.recipient.should eq member2
      n.subject.should match(/mentioned you in their post/)
      n.body.should eq p.body
    end

    it "sends notifications to all members mentioned" do
      member3 = FactoryGirl.create(:member)
      expect do
        FactoryGirl.create(:post, author: member, body: "Hey @#{member2} & @#{member3}")
      end.to change(Notification, :count).by(2)
    end

    it "doesn't send notifications if you mention yourself" do
      expect do
        FactoryGirl.create(:post, author: member, body: "@#{member}")
      end.to change(Notification, :count).by(0)
    end
  end

  context "crop-post association" do
    let!(:tomato) { FactoryGirl.create(:tomato) }
    let!(:maize) { FactoryGirl.create(:maize) }
    let!(:chard) { FactoryGirl.create(:chard) }
    let!(:post) { FactoryGirl.create(:post, body: "[maize](crop)[tomato](crop)[tomato](crop)") }

    it "should be generated" do
      expect(tomato.posts).to eq [post]
      expect(maize.posts).to eq [post]
    end

    it "should not duplicate" do
      expect(post.crops) =~ [tomato, maize]
    end

    it "should be updated when post was modified" do
      post.update_attributes(body: "[chard](crop)")

      expect(post.crops).to eq [chard]
      expect(chard.posts).to eq [post]
      expect(tomato.posts).to eq []
      expect(maize.posts).to eq []
    end

    describe "destroying the post" do
      before do
        post.destroy
      end

      it "should delete the association" do
        expect(Crop.find(tomato.id).posts).to eq []
        expect(Crop.find(maize.id).posts).to eq []
      end

      it "should not delete the crops" do
        expect(Crop.find(tomato.id)).to_not eq nil
        expect(Crop.find(maize.id)).to_not eq nil
      end
    end
  end
end
