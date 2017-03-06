include ActiveModel::Validations

class EmailValidator < ActiveModel::Validator
   def validate(record)
      if record.email.present? && record.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i 
         return true 
      end
      record.errors[:base] << "provide a proper email"
   end
end


class TitleValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, "must start with 'the'" unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i 
  end
end