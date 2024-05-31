import { IsEmail, IsNotEmpty, IsString, IsNumber, IsStrongPassword, MinLength } from 'class-validator';


export class LogInDto {

  
   @IsNotEmpty()
   @IsString()
   readonly username: string;


   @IsNotEmpty()
   readonly password: string;
}