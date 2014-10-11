module BootstrapInputs
  class TextInput < SimpleForm::Inputs::TextInput
    def input_html_class
      super.push 'form-control'
    end
  end
end