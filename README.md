# Give A Talk

Give a talk:

User - Registered
<!-- has_many :events -->
<!-- has_many :organization_events, through: :organizations -->
<!-- has_many :organizations -->
<!-- has_many :talks -->

Organization
name:string url:string about:text
belongs_to :user
<!-- has_many :events, as: :eventable -->
<!-- has_many :talks, through: :events -->
<!-- has_many :attendees, through: :events -->

Event
name description:text begins_at:datetime ends_at:datetime website:string eventable:references
Polymorphic
belongs_to :user
belongs_to :organization
<!-- has_many :attendees, class: User -->
<!-- has_many :talks -->


sessions/meetups/meetings

Talks talk_type  title  description:text  justification:text  video  presentation  status  resources:hstore user:references event:references
Talk type - lightning, conference, meetup
slots
duration
resources, links
accepted, rejected

Tags

Comment
message:text
belongs_to :commentable
belongs_to :user


h2. Ruby on Rails

This application requires:

* Ruby version 2.0.0
* Rails version 4.0.2


h2. Database

This application uses PostgreSQL with ActiveRecord.

h2. Development

* Template Engine: Haml
* Testing Framework: Test::Unit
* Front-end Framework: Zurb Foundation 5
* Form Builder: SimpleForm
* Authentication: Devise
* Authorization: CanCan

h2. Email

The application is configured to send email using a Mandrill account.

h2. Getting Started

Lorem ipsum dolor sit amet, consectetur adipiscing elit.

h2. Documentation and Support

This is the only documentation.

h4. Issues

Lorem ipsum dolor sit amet, consectetur adipiscing elit.

h2. Similar Projects

Lorem ipsum dolor sit amet, consectetur adipiscing elit.

h2. Contributing

If you make improvements to this application, please share with others.

* Fork the project on GitHub.
* Make your feature addition or bug fix.
* Commit with Git.
* Send the author a pull request.

If you add functionality to this application, create an alternative implementation, or build an application that is similar, please contact me and I'll add a note to the README so that others can find your work.

h2. Credits

Lorem ipsum dolor sit amet, consectetur adipiscing elit.

h2. License

Lorem ipsum dolor sit amet, consectetur adipiscing elit.
