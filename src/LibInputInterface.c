 static int open_restricted(const char *path, int flags, void *user_data)
{
        int fd = open(path, flags);
        return fd < 0 ? -errno : fd;
}
 
static void close_restricted(int fd, void *user_data)
{
        close(fd);
}
 
const static struct libinput_interface interface = {
        .open_restricted = open_restricted,
        .close_restricted = close_restricted,
};