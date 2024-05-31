import { IsNotEmpty, IsString } from "class-validator";
import { File } from 'multer';

export class CreatePostsDto {

    @IsNotEmpty()
    @IsString()
    readonly name: string;

    @IsNotEmpty()
    @IsString()
    readonly description: string;

    @IsNotEmpty()
    @IsString()
    readonly contact: string;

    @IsNotEmpty()
    @IsString()
    readonly user: string;

    readonly image: File;
}
