module EventsHelper
  def eventable_collection
    collection = []
    if @organization
      collection << [@organization.name, [@organization.class.name, @organization.id]]
    end

    if @user
      collection << [@user.full_name, [@user.class.name, @user.id]]
    end
    other_orgs = @user.organizations - [@organization]
    if other_orgs
      other_orgs.each do |org| 
        collection << [ org.name, [org.class.name, org.id]]
      end
    end
    collection
  end

  def display_talk_type(event)
    case event.talks_type
    when 'lightning'
      classes = 'fa fa-bolt'
    when 'presentation'
      classes = 'fi-microphone'
    when 'conference'
      classes = 'fi-projection-screen'
    end
    "<i class='#{classes}'></i> #{event.talks_type.titleize}".html_safe
  end
end