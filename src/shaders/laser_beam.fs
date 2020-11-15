#define PI 3.14159265358979323846
extern vec2 resolution;
extern float time;
extern vec2 position;

float Circle(vec2 uv, vec2 pos, float radius, float step_size)
{
  uv.y *= 2;
  float d = length(uv - pos);                           // distance from every pixel to pos
  float c = radius / d;
  //float c = smoothstep(radius, radius - step_size, d);  // smooth edge of the circle (reversed to go from high to low!)
  
  return c;
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
  vec2 uv = vec2(screen_coords.x / resolution.x, screen_coords.y / resolution.y); // normalize coords
  float aspect_ratio = resolution.x / resolution.y;
  uv.x *= aspect_ratio;  // multiply x by aspect ratio to compensate for the width vs height difference
  
  uv.y -= position.y / resolution.y;
  uv.x -= position.x / resolution.x * aspect_ratio;
  
  vec4 col = vec4(0.);
  vec4 beam_color = vec4(1., 1., 0., 1.);
  
  float c = Circle(uv, vec2(0.), .07, 0.01);
  col += c * beam_color;
  
  float beam = max(0, 1 - abs(uv.y * 25));
  if (uv.x < .0 || time * 5 - uv.x < .0) beam = 0;
  
  col += beam * beam_color;
  
  return vec4(col);              // use the same c value for r, g and b
}