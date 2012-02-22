module ApplicationHelper
  def new_translations_link(mail,languages)
    content = ""
    languages.each do |l|
      existing_translation = l.translations.where("mailer_id = ?",mail.id).first
      content += translation_language_link(existing_translation,mail,l)
      content += ' '
    end 
    content.html_safe
  end
  
  def translation_language_link(existing_translation,mail,l)
    if existing_translation
      link_to(l.name,edit_mail_translation_path(mail,existing_translation,:page=>@page), :class=>"edit")
    else
      link_to(l.name,new_mail_translation_path(mail,:language_id => l,:page=>@page), :class=>"new")
    end
  end
  
  
  def key_translations_link(key,languages,countries)
    content = ""
    reference=key.references
    
    reference.each do |r|
      content+=hr('gris')
      content+="<tr class='empty' height='22'>
      <td width='20'></td>
      <td class='gris padding' colspan='3'>#{r.country.name}</td>
      <td class='gris' align='center'>#{link_to image_tag("trash.png", :border=>0), key_reference_path(:key_id=>key,:id=>r,:pagination=>@pagination, :search => @search), :confirm => 'Are you sure?', :method => :delete}</td></tr>"
      content+=hr('gris')
      
      languages.each do |l|
        existing_translation = l.keys_translations.where("reference_id = ? ",r.id).first
        content += key_translation_language_link(existing_translation,r,l)
        content += ' '
      end 
    end
    content.html_safe
  end
  
  def key_translation_language_link(existing_translation,r,l)
    content=""
    if existing_translation
      content+="<tr class='empty' height='22'>
      <td width='20'></td><td class='vert align verticaltop' width='30'>#{l.name.upcase}</td>
      <td class='vert padding '>#{existing_translation.value}</td>
      <td class='align vert verticaltop'>#{link_to 'Edit', edit_reference_keys_translation_path(:page=>@page,:reference_id=>r,:id=>existing_translation.id,:pagination=>@pagination, :search => @search)}</td>
      <td class='align vert verticaltop'>#{link_to image_tag("trash.png", :border=>0), reference_keys_translation_path(:page=>@page,:reference_id=>r.id,:id=>existing_translation.id,:pagination=>@pagination, :search => @search), :confirm => 'Are you sure?', :method => :delete}</td></tr>#{hr('vert')}"
    else
      content+="<tr  class='empty' height='22'>
      <td  width='20'></td><td class='rouge align' width='30'>#{l.name.upcase}</td>
      <td  class='rouge padding'>no translation</td>
      <td class='align rouge'>#{link_to 'New', new_reference_keys_translation_path(:page=>@page,:reference_id=>r,:language_id => l, :pagination=>@pagination, :search => @search)}</td>
      <td class='align rouge'></td></tr>#{hr('rouge')}"
    end
    content.html_safe
  end
  
  def hr(class_name)
   "<tr height='3'><td class='empty'></td><td colspan='4' class='#{class_name}'><hr></td></tr>".html_safe
  end 
  def indexer()
    @index+=1
  end

  def replace_data(text,options)
    options.each {|key, value| 
      r = Regexp.new(key, true)
      text = text.gsub(r, value)
    }
    text.html_safe
  end
  
  def check_url(translation)
    if translation.body
      case translation.language.name
        when 'fr'
          if translation.body.include?('private.dvdpost.com/en/') === true  || translation.body.include?('private.dvdpost.com/nl/')  === true
            false
          else
            true
          end
        when 'en'
          if translation.body.include?('private.dvdpost.com/fr/') === true || translation.body.include?('private.dvdpost.com/nl/')  === true
            false
          else
            true
          end
        when 'nl'
          if translation.body.include?('private.dvdpost.com/en/') === true || translation.body.include?('private.dvdpost.com/fr/')  === true
            false
          else
            true
          end
      end
    else
      true
    end
  end
  
  def mail_title (name)
    if name.empty?
      "unnamed"
    else
      name
    end
  end
end
