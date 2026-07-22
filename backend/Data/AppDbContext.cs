using Microsoft.EntityFrameworkCore;
using backend.Models;

namespace backend.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

    public DbSet<User> Users => Set<User>();
    public DbSet<Role> Roles => Set<Role>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        var user = modelBuilder.Entity<User>();
        user.ToTable("User");
        user.Property(u => u.UserId).HasColumnName("userid");
        user.Property(u => u.FirstName).HasColumnName("firstname");
        user.Property(u => u.LastName).HasColumnName("lastname");
        user.Property(u => u.Email).HasColumnName("email");
        user.Property(u => u.PasswordHash).HasColumnName("passwordhash");
        user.Property(u => u.RoleId).HasColumnName("roleid");
        user.Property(u => u.IsActive).HasColumnName("isactive");
        user.Property(u => u.CreatedDate).HasColumnName("createddate");

        var role = modelBuilder.Entity<Role>();
        role.ToTable("role");
        role.Property(r => r.RoleId).HasColumnName("roleid");
        role.Property(r => r.RoleName).HasColumnName("rolename");
        role.Property(r => r.Description).HasColumnName("description");
    }
}
