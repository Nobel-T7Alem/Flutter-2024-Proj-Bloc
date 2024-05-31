import { Injectable, UnauthorizedException } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { PassportStrategy } from "@nestjs/passport";
import { Model } from "mongoose";
import { Strategy, ExtractJwt } from "passport-jwt";
import { User, UserRole} from "../user/schemas/user.schema";



@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
    constructor(
        @InjectModel(User.name)
        private userModel: Model<User>
    ) {
        super({
            jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
            secretOrKey: process.env.JWT_SECRET
        })
    }

    async validate(payload) {
        const { id } = payload;

        const user = await this.userModel.findById(id);

        if (!user) {
            throw new UnauthorizedException('Login first to access this endpoint.')
        }
        return user;

    }

}


@Injectable()
export class AdminStrategy extends PassportStrategy(Strategy, 'admin') {
  constructor() {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: process.env.JWT_SECRET
    });
  }

  async validate(payload) {
    const { role } = payload;

    if (role !== UserRole.Admin) {
      throw new UnauthorizedException('Only admins can access this endpoint.');
    }

    return payload;
  }
}

@Injectable()
export class UserRoleStrategy extends PassportStrategy(Strategy, 'user') {
  constructor() {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: process.env.JWT_SECRET
    });
  }

  async validate(payload) {
    const { role } = payload;

    if (role !== UserRole.User) {
      throw new UnauthorizedException('Only users can access this endpoint.');
    }

    return payload;
  }
}

@Injectable()
export class AgencyRoleStrategy extends PassportStrategy(Strategy, 'agency') {
  constructor() {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: process.env.JWT_SECRET
    });
  }

  async validate(payload) {
    const { role } = payload;

    if (role !== UserRole.Agency) {
      throw new UnauthorizedException('Only agencies can access this endpoint.');
    }

    return payload;
  }
}