import { File } from 'multer';
export declare class CreatePostsDto {
    readonly name: string;
    readonly description: string;
    readonly contact: string;
    readonly user: string;
    readonly image: File;
}
