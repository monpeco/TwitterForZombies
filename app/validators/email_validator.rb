class EmailValidator < ActiveModel::Validator
   def validate_each(record, attribute, value)
      record.errors.add attribute, (option[:message] || "it is not a email") unless 
      value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
   end
   def validate(record)
      if record.email.present? && record.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i 
         return true 
      end
      record.errors[:base] << "provide a proper email"
   end
end