@interface Shape: NSObject
- (float)area; // return 0
- (float)perimeter; // return 0
- (NSString *)description; // return string with memory address, NSStringFromClass([self class]), area, perimeter
@end

@interface Circle: Shape
// provide init with radius, validate for negative value
// provide class method for create instance
- (BOOL)isEqualToCircle:(Circle *)other;
- (BOOL)isEqual:(id)other;
@end

@interface Rectangle: Shape
// provide init with sides, validate for negative values
// provide class method for create instance
- (BOOL)isEqualToRectangle:(Rectangle *)other;
- (BOOL)isEqual:(id)other;
@end

@interface Triangle: Shape
// provide init with sides, return nil if a >= b + c ????, validate for negative values
// provide class method for create instance
- (BOOL)isEqualToTriangle:(Triangle *)other;
- (BOOL)isEqual:(id)other;
@end
