import { Module } from '@nestjs/common';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { MongooseModule } from '@nestjs/mongoose';
import { User, UserSchema } from '../user/schemas/user.schema';
import { PassportModule } from '@nestjs/passport';
import { JwtModule } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { ConfigModule } from '@nestjs/config';
import { AgencyRoleStrategy, JwtStrategy, UserRoleStrategy } from './jwt.strategy';
import { AdminStrategy } from './jwt.strategy';


@Module({
  imports: [
    ConfigModule.forRoot(),
    PassportModule.register({defaultStrategy:'jwt'}),
    JwtModule.registerAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: (config: ConfigService) => {
        return {
          secret: config.get<string>('JWT_SECRET'),
          signOptions: {
            expiresIn: config.get<string | number>('JWT_EXPIRES')
          },
        }
      }
    }),
    MongooseModule.forFeature([{name: User.name, schema:UserSchema}])
  ],
  controllers: [AuthController],
  providers: [AuthService, JwtStrategy, AdminStrategy, UserRoleStrategy, AgencyRoleStrategy],
  exports: [JwtStrategy, PassportModule, AdminStrategy, UserRoleStrategy, AgencyRoleStrategy]
})
export class AuthModule {}
