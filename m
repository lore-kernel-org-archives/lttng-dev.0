From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Add with-sessiond-bin configure
 option
Date: Tue, 19 Mar 2013 15:19:13 -0400
Message-ID: <5148BA31.6060803__24606.0181213126$1363720813$gmane$org@efficios.com>
References: <1362094937-6677-1-git-send-email-simon.marchi@polymtl.ca>
	<CAFXXi0kGM8G6rjwBvkJhZyw5F2UppKmy4nMUnWUTY=iQaz7z=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UI244-0008AC-P8
	for lttng-dev@lists.lttng.org; Tue, 19 Mar 2013 15:19:17 -0400
In-Reply-To: <CAFXXi0kGM8G6rjwBvkJhZyw5F2UppKmy4nMUnWUTY=iQaz7z=A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

It's still on my stack. Don't worry.

I have my hands full with the 2.2 development. Don't worry, this will be
review and merged before the release.

Thanks
David

Simon Marchi:
> Bump.
> 
> On 28 February 2013 18:42, Simon Marchi <simon.marchi@polymtl.ca> wrote:
>> I also cleaned up the little check_sessiond function. The check using
>> access(2) was only done for the command line option, but I think it is a
>> good idea to do it wherever the path comes from.
>>
>> closes #441
>>
>> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
>> ---
>>  configure.ac          |   17 +++++++++++++++++
>>  src/bin/lttng/lttng.c |   37 ++++++++++++++++++++-----------------
>>  2 files changed, 37 insertions(+), 17 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 71fbb60..7349713 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -91,12 +91,20 @@ AC_ARG_WITH([consumerd64-libdir],
>>         [CONSUMERD64_LIBDIR=''])
>>  AC_SUBST([CONSUMERD64_LIBDIR])
>>
>> +AC_ARG_WITH([sessiond-bin],
>> +       AS_HELP_STRING([--with-sessiond-bin],
>> +       [Location of the sessiond executable (including the filename)]),
>> +       [SESSIOND_BIN="$withval"],
>> +       [SESSIOND_BIN=''])
>> +AC_SUBST([SESSIOND_BIN])
>> +
>>  AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD32_BIN], "$CONSUMERD32_BIN", [Location of the 32-bit consumerd executable.])
>>  AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD64_BIN], "$CONSUMERD64_BIN", [Location of the 64-bit consumerd executable])
>>  AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD32_LIBDIR], "$CONSUMERD32_LIBDIR", [Search for consumerd 32-bit libraries in this location.])
>>  AC_DEFINE_UNQUOTED([CONFIG_CONSUMERD64_LIBDIR], "$CONSUMERD64_LIBDIR", [Search for consumerd 64-bit libraries in this location.])
>>  AC_DEFINE_UNQUOTED([CONFIG_BABELTRACE_BIN], "$BABELTRACE_BIN", [Location of the babeltrace viewer executable.])
>>  AC_DEFINE_UNQUOTED([CONFIG_LTTV_GUI_BIN], "$LTTV_GUI_BIN", [Location of the lttv GUI viewer executable.])
>> +AC_DEFINE_UNQUOTED([CONFIG_SESSIOND_BIN], "$SESSIOND_BIN", [Location of the sessiond executable.])
>>
>>  # Check for pthread
>>  AC_CHECK_LIB([pthread], [pthread_create], [],
>> @@ -383,6 +391,15 @@ AS_ECHO("`eval eval echo $libdir`")
>>  # If we build the sessiond, print the paths it will use
>>  AS_IF([test "x$consumerd_only" = "xno"],[
>>         AS_ECHO()
>> +       AS_ECHO_N("The lttng command will look for the lttng-sessiond executable at: ")
>> +       AS_IF([test "$SESSIOND_BIN" = ""],[
>> +               AS_ECHO_N("`eval eval echo $bindir`")
>> +               AS_ECHO("/lttng-sessiond")
>> +       ],[
>> +               AS_ECHO("$SESSIOND_BIN")
>> +       ])
>> +
>> +       AS_ECHO()
>>         AS_ECHO("The sessiond daemon will look in the following directories: ")
>>         AS_ECHO_N("32-bit consumerd executable at: ")
>>         AS_IF([test "$CONSUMERD32_BIN" = ""],[
>> diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c
>> index 8562144..4097956 100644
>> --- a/src/bin/lttng/lttng.c
>> +++ b/src/bin/lttng/lttng.c
>> @@ -346,35 +346,38 @@ end:
>>  static int check_sessiond(void)
>>  {
>>         int ret;
>> -       char *pathname = NULL, *alloc_pathname = NULL;
>> +       char *pathname = NULL;
>>
>>         ret = lttng_session_daemon_alive();
>>         if (ret == 0) { /* not alive */
>>                 /* Try command line option path */
>> -               if (opt_sessiond_path != NULL) {
>> -                       ret = access(opt_sessiond_path, F_OK | X_OK);
>> -                       if (ret < 0) {
>> -                               ERR("No such file or access denied: %s", opt_sessiond_path);
>> -                               goto end;
>> -                       }
>> -                       pathname = opt_sessiond_path;
>> -               } else {
>> -                       /* Try LTTNG_SESSIOND_PATH env variable */
>> +               pathname = opt_sessiond_path;
>> +
>> +               /* Try LTTNG_SESSIOND_PATH env variable */
>> +               if (pathname == NULL) {
>>                         pathname = getenv(DEFAULT_SESSIOND_PATH_ENV);
>>                 }
>>
>> -               /* Let's rock and roll */
>> +               /* Try with configured path */
>>                 if (pathname == NULL) {
>> -                       ret = asprintf(&alloc_pathname, INSTALL_BIN_PATH "/lttng-sessiond");
>> -                       if (ret < 0) {
>> -                               perror("asprintf spawn sessiond");
>> -                               goto end;
>> +                       if (CONFIG_SESSIOND_BIN[0] != '\0') {
>> +                               pathname = CONFIG_SESSIOND_BIN;
>>                         }
>> -                       pathname = alloc_pathname;
>> +               }
>> +
>> +               /* Let's rock and roll while trying the default path */
>> +               if (pathname == NULL) {
>> +                       pathname = INSTALL_BIN_PATH "/lttng-sessiond";
>> +               }
>> +
>> +               /* Check existence and permissions */
>> +               ret = access(pathname, F_OK | X_OK);
>> +               if (ret < 0) {
>> +                       ERR("No such file or access denied: %s", pathname);
>> +                       goto end;
>>                 }
>>
>>                 ret = spawn_sessiond(pathname);
>> -               free(alloc_pathname);
>>                 if (ret < 0) {
>>                         ERR("Problem occurred when starting %s", pathname);
>>                         goto end;
>> --
>> 1.7.1
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
