using DataTransferObjects.Configuration;
using Logic.Implementations;
using Logic.Intefaces;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Security.Implementations;
using Security.Interfaces;
using System.Text;
using UnitOfWork.Interfaces;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<IUnitOfWork>(option => new UnitOfWork.Implementations.UnitOfWork(builder!.Configuration!.GetConnectionString("SQLServerConnection")!));

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.Configure<TokenConfiguration>(builder.Configuration.GetSection("JwtConfig"));

var token = builder.Configuration.GetSection("JwtConfig").Get<TokenConfiguration>();
var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(token!.Secret!));

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(opt =>
                {
                    opt.RequireHttpsMetadata = false;
                    opt.SaveToken = true;
                    opt.TokenValidationParameters = new TokenValidationParameters
                    {
                        ValidateIssuerSigningKey = true,
                        IssuerSigningKey = key,
                        ValidateAudience = false,
                        ValidateIssuer = false,
                        ClockSkew = TimeSpan.Zero
                    };
                });

builder.Services.AddTransient<IAuthenticationLogic, AuthenticationLogic>();
builder.Services.AddTransient<IAnimalLogic, AnimalLogic>();
builder.Services.AddTransient<IOrderLogic, OrderLogic>();

builder.Services.AddScoped<ITokenGeneratorHandler, TokenGeneratorHandler>();



builder.Services.AddCors(o => o.AddPolicy("corsapp", builder =>
{
    builder.WithOrigins("*").AllowAnyMethod().AllowAnyHeader().AllowAnyOrigin();
}));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseAuthentication();
app.UseCors("corsapp");

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
