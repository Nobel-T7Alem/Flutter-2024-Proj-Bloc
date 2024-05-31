import { Body, Post, Controller, Get, Query, Catch } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LogInDto } from '../user/dto/login.dto';
import { SignUpDto } from '../user/dto/signup.dto';


@Controller('auth')
export class AuthController {
    constructor(private authService: AuthService) { }

    @Post('/signup')
    signUp(@Body() signUpDto: SignUpDto): Promise<any> {
        return this.authService.signUp(signUpDto);
    }
    @Get('/login')
    login(@Query() loginDto: LogInDto): Promise<{ token: string }> {
        return this.authService.login(loginDto);
    }
}
