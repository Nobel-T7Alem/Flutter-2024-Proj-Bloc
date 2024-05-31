import { IsEmail, IsNotEmpty, IsString, registerDecorator, ValidationOptions, ValidatorConstraint, ValidatorConstraintInterface, MinLength, IsStrongPassword } from 'class-validator';
import { UserService } from 'src/user/user.service';
import { Injectable } from '@nestjs/common';

@Injectable()
@ValidatorConstraint({ async: true })
export class IsUniqueConstraint implements ValidatorConstraintInterface {
  constructor(private readonly userService: UserService) { }

  async validate(value: any): Promise<boolean> {
    const user = await this.userService.findByUsername(value);
    // return !user;
    return user === null || user === undefined;
  }

  defaultMessage(): string {
    return 'Username is already taken';
  }
}

export function IsUnique(validationOptions?: ValidationOptions) {
  return function (object: Object, propertyName: string): void {
    registerDecorator({
      name: 'isUnique',
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      validator: IsUniqueConstraint,
    });
  };
}


export class SignUpDto {

  @IsNotEmpty()
  @IsString()
  readonly name: string;

  @IsNotEmpty()
  @IsString()
  
  readonly username: string;

  @IsNotEmpty()
  @IsEmail({ message: 'Please enter correct email' })
  readonly email: string;

  @IsNotEmpty()
  @MinLength(6)
  readonly password: string;

  @IsNotEmpty()
  @IsString()
  readonly role: string;

}