import { AuthService } from './auth.service';
import { LogInDto } from '../user/dto/login.dto';
import { SignUpDto } from '../user/dto/signup.dto';
export declare class AuthController {
    private authService;
    constructor(authService: AuthService);
    signUp(signUpDto: SignUpDto): Promise<any>;
    login(loginDto: LogInDto): Promise<{
        token: string;
    }>;
}
