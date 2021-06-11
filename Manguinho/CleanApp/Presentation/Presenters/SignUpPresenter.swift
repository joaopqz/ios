import Foundation

public final class SignUpPresenter {
    
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    
    public init (alertView: AlertView, emailValidator: EmailValidator){
        self.alertView = alertView
        self.emailValidator = emailValidator
    }
    
    public  func signUp(viewModel: SignUpViewModel){
        if let message = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        }
    }
    
    private func validate(viewModel: SignUpViewModel) -> String? {
        if viewModel.name == nil || viewModel.name!.isEmpty {
            return "Campo NOME é obrigatório!!"
        } else if viewModel.email == nil || viewModel.email!.isEmpty {
            return "Campo EMAIL é obrigatório!!"
        } else if viewModel.password == nil || viewModel.password!.isEmpty {
             return  "Campo SENHA é obrigatório!!"
        } else if viewModel.passwordConfimation == nil || viewModel.passwordConfimation!.isEmpty {
            return "Campo CONFIRMAR SENHA é obrigatório!!"
        } else if viewModel.passwordConfimation != viewModel.password{
            return "Falha ao confirmar senha!!"
        } else if !emailValidator.isValid(email:viewModel.email!){
            return "Email inválido!!"
        }
        return nil
    }
    
}

public struct SignUpViewModel{
    public var name: String?
    public var email: String?
    public var password: String?
    public var passwordConfimation: String?
    
    public init (name: String? = nil, email: String? = nil, password: String? = nil, passwordConfimation: String? = nil){
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfimation = passwordConfimation
    }
}