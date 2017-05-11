From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: Re: [PATCH] Test: Replace test relying pselect6(2) man
	page error
Date: Thu, 11 May 2017 15:40:26 -0400
Message-ID: <CADcCL0jrEXcjnfVB1Rm5JNB+GBy5=i1+WWptcV7swFQqqmTAVQ__15323.7069528133$1494531746$gmane$org@mail.gmail.com>
References: <1494531417-9929-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5206813090916912168=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-x22c.google.com (mail-it0-x22c.google.com
 [IPv6:2607:f8b0:4001:c0b::22c])
 by lists.lttng.org (Postfix) with ESMTPS id 3wP3PM0KgRzyjS
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2017 19:40:54 +0000 (UTC)
Received: by mail-it0-x22c.google.com with SMTP id c15so50258791ith.0
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2017 12:40:47 -0700 (PDT)
In-Reply-To: <1494531417-9929-1-git-send-email-francis.deslauriers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============5206813090916912168==
Content-Type: multipart/alternative; boundary="001a11373292e6cca7054f44c341"

--001a11373292e6cca7054f44c341
Content-Type: text/plain; charset="UTF-8"

Sorry for the missing [PATCH lttng-tools]

2017-05-11 15:36 GMT-04:00 Francis Deslauriers <
francis.deslauriers@efficios.com>:

> The `pselect_fd_too_big` test is checking for the case where the `nfds`
> is larger than the number of open files allowed for this process
> (RLIMIT_NOFILE). According to the man page, if `nfds` > RLIMIT_NOFILE is
> evaluate to true the pselect6 syscall should return EINVAL.
>
> In fact, the Linux implementation of the pselect6 syscall[1] does not
> compare the `nfds` and RLIMIT_NOFILE but rather caps `nfds` to the
> highest numbered fd of the current process.
>
> It was observed elsewhere that there is a discrepancy between the manual
> page and the implementation [2].
>
> As a solution, replace the current testcase with one that checks the
> behaviour of the syscall when passed an invalid FD.
>
> [1]:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds
> /linux.git/tree/fs/select.c#n619
> [2]:https://patchwork.kernel.org/patch/9345805/
>
> Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  tests/regression/kernel/select_poll_epoll.c        | 39
> +++++++++++++---------
>  tests/regression/kernel/test_select_poll_epoll     |  6 ++--
>  .../kernel/validate_select_poll_epoll.py           | 13 ++++----
>  3 files changed, 33 insertions(+), 25 deletions(-)
>
> diff --git a/tests/regression/kernel/select_poll_epoll.c
> b/tests/regression/kernel/select_poll_epoll.c
> index 4b703b3..1d767b0 100644
> --- a/tests/regression/kernel/select_poll_epoll.c
> +++ b/tests/regression/kernel/select_poll_epoll.c
> @@ -437,30 +437,38 @@ void ppoll_fds_ulong_max(void)
>  }
>
>  /*
> - * Select is limited to 1024 FDs, should output a pselect event
> - * with 0 FDs.
> + * Pass a invalid file descriptor to pselect6(). The syscall should return
> + * -EBADF. The recorded event should contain a ret=-EBADF (-9).
>   */
> -void pselect_fd_too_big(void)
> +void pselect_invalid_fd(void)
>  {
> -       long rfds[2048 / (sizeof(long) * CHAR_BIT)] = { 0 };
> +       fd_set rfds;
>         int ret;
> -       int fd2;
> +       int fd;
>         char buf[BUF_SIZE];
>
>         /*
> -        * Test if nfds > 1024.
> -        * Make sure ulimit is set correctly (ulimit -n 2048).
> +        * Open a file, close it and use the closed FD in the pselect6 call
>          */
> -       fd2 = dup2(wait_fd, 2047);
> -       if (fd2 != 2047) {
> -               perror("dup2");
> -               return;
> +
> +       fd = open("/dev/null", O_RDONLY);
> +       if (fd == -1) {
> +               perror("open");
> +               goto error;
>         }
>
> -       FD_SET(fd2, (fd_set *) &rfds);
> -       ret = syscall(SYS_pselect6, fd2 + 1, &rfds, NULL, NULL, NULL,
> NULL);
> +       ret = close(fd);
>
>         if (ret == -1) {
> +               perror("close");
> +               goto error;
> +       }
> +
> +       FD_ZERO(&rfds);
> +       FD_SET(fd, &rfds);
> +
> +       ret = syscall(SYS_pselect6, fd + 1, &rfds, NULL, NULL, NULL, NULL);
> +       if (ret == -1) {
>                 perror("# pselect()");
>         } else if (ret) {
>                 printf("# [pselect] data available\n");
> @@ -471,7 +479,8 @@ void pselect_fd_too_big(void)
>         } else {
>                 printf("# [pselect] timeout\n");
>         }
> -
> +error:
> +       return;
>  }
>
>  /*
> @@ -892,7 +901,7 @@ int main(int argc, const char **argv)
>                 run_working_cases();
>                 break;
>         case 3:
> -               pselect_fd_too_big();
> +               pselect_invalid_fd();
>                 break;
>         case 4:
>                 test_ppoll_big();
> diff --git a/tests/regression/kernel/test_select_poll_epoll
> b/tests/regression/kernel/test_select_poll_epoll
> index e01866f..ec034e6 100755
> --- a/tests/regression/kernel/test_select_poll_epoll
> +++ b/tests/regression/kernel/test_select_poll_epoll
> @@ -126,13 +126,13 @@ function test_timeout_cases()
>         rm -rf $TRACE_PATH
>  }
>
> -function test_big_pselect()
> +function test_pselect_invalid_fd()
>  {
>         TRACE_PATH=$(mktemp -d)
>         SESSION_NAME="syscall_payload"
>         SYSCALL_LIST="pselect6"
>
> -       diag "pselect with a FD > 1023"
> +       diag "pselect with invalid FD"
>
>         create_lttng_session_ok $SESSION_NAME $TRACE_PATH
>
> @@ -384,7 +384,7 @@ skip $isroot "Root access is needed. Skipping all
> tests." $NUM_TESTS ||
>
>         test_working_cases
>         test_timeout_cases
> -       test_big_pselect
> +       test_pselect_invalid_fd
>         test_big_ppoll
>         test_ppoll_overflow
>         test_pselect_invalid_ptr
> diff --git a/tests/regression/kernel/validate_select_poll_epoll.py
> b/tests/regression/kernel/validate_select_poll_epoll.py
> index f4946e7..613cec3 100755
> --- a/tests/regression/kernel/validate_select_poll_epoll.py
> +++ b/tests/regression/kernel/validate_select_poll_epoll.py
> @@ -450,8 +450,8 @@ class Test2(TraceParser):
>  class Test3(TraceParser):
>      def __init__(self, trace, pid):
>          super().__init__(trace, pid)
> -        self.expect["select_too_big_in"] = 0
> -        self.expect["select_too_big_out"] = 0
> +        self.expect["select_invalid_fd_in"] = 0
> +        self.expect["select_invalid_fd_out"] = 0
>
>      def select_entry(self, event):
>          timestamp = event.timestamp
> @@ -466,9 +466,8 @@ class Test3(TraceParser):
>          _exceptfds_length = event["_exceptfds_length"]
>          exceptfds = event["exceptfds"]
>
> -        # make sure an invalid value still produces a valid event
> -        if n == 2048 and overflow == 0 and _readfds_length == 0:
> -            self.expect["select_too_big_in"] = 1
> +        if n > 0 and overflow == 0:
> +            self.expect["select_invalid_fd_in"] = 1
>
>      def select_exit(self, event):
>          timestamp = event.timestamp
> @@ -483,9 +482,9 @@ class Test3(TraceParser):
>          _exceptfds_length = event["_exceptfds_length"]
>          exceptfds = event["exceptfds"]
>
> -        # make sure an invalid value still produces a valid event
> +        # make sure the event has a ret field equal to -EBADF
>          if ret == -9 and overflow == 0 and _readfds_length == 0:
> -            self.expect["select_too_big_out"] = 1
> +            self.expect["select_invalid_fd_out"] = 1
>
>
>  class Test4(TraceParser):
> --
> 2.7.4
>
>


-- 
Francis Deslauriers
Software developer
EfficiOS inc.

--001a11373292e6cca7054f44c341
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry for the missing [PATCH lttng-tools]<div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">2017-05-11 15:36 GMT-04:00 Francis=
 Deslauriers <span dir=3D"ltr">&lt;<a href=3D"mailto:francis.deslauriers@ef=
ficios.com" target=3D"_blank">francis.deslauriers@efficios.<wbr>com</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">The `pselect_fd_too_big` test is=
 checking for the case where the `nfds`<br>
is larger than the number of open files allowed for this process<br>
(RLIMIT_NOFILE). According to the man page, if `nfds` &gt; RLIMIT_NOFILE is=
<br>
evaluate to true the pselect6 syscall should return EINVAL.<br>
<br>
In fact, the Linux implementation of the pselect6 syscall[1] does not<br>
compare the `nfds` and RLIMIT_NOFILE but rather caps `nfds` to the<br>
highest numbered fd of the current process.<br>
<br>
It was observed elsewhere that there is a discrepancy between the manual<br=
>
page and the implementation [2].<br>
<br>
As a solution, replace the current testcase with one that checks the<br>
behaviour of the syscall when passed an invalid FD.<br>
<br>
[1]:<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git/tree/fs/select.c#n619" rel=3D"noreferrer" target=3D"_blank">https://=
git.kernel.org/pub<wbr>/scm/linux/kernel/git/torvalds<wbr>/linux.git/tree/f=
s/select.c#<wbr>n619</a><br>
[2]:<a href=3D"https://patchwork.kernel.org/patch/9345805/" rel=3D"noreferr=
er" target=3D"_blank">https://patchwork.kernel.o<wbr>rg/patch/9345805/</a><=
br>
<br>
Signed-off-by: Francis Deslauriers &lt;<a href=3D"mailto:francis.deslaurier=
s@efficios.com" target=3D"_blank">francis.deslauriers@efficios.<wbr>com</a>=
&gt;<br>
Signed-off-by: Julien Desfossez &lt;<a href=3D"mailto:jdesfossez@efficios.c=
om" target=3D"_blank">jdesfossez@efficios.com</a>&gt;<br>
---<br>
=C2=A0tests/regression/kernel/selec<wbr>t_poll_epoll.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 39 +++++++++++++---------<br>
=C2=A0tests/regression/kernel/test_<wbr>select_poll_epoll=C2=A0 =C2=A0 =C2=
=A0|=C2=A0 6 ++--<br>
=C2=A0.../kernel/validate_select_po<wbr>ll_epoll.py=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 13 ++++----<br>
=C2=A03 files changed, 33 insertions(+), 25 deletions(-)<br>
<br>
diff --git a/tests/regression/kernel/sele<wbr>ct_poll_epoll.c b/tests/regre=
ssion/kernel/sele<wbr>ct_poll_epoll.c<br>
index 4b703b3..1d767b0 100644<br>
--- a/tests/regression/kernel/sele<wbr>ct_poll_epoll.c<br>
+++ b/tests/regression/kernel/sele<wbr>ct_poll_epoll.c<br>
@@ -437,30 +437,38 @@ void ppoll_fds_ulong_max(void)<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
- * Select is limited to 1024 FDs, should output a pselect event<br>
- * with 0 FDs.<br>
+ * Pass a invalid file descriptor to pselect6(). The syscall should return=
<br>
+ * -EBADF. The recorded event should contain a ret=3D-EBADF (-9).<br>
=C2=A0 */<br>
-void pselect_fd_too_big(void)<br>
+void pselect_invalid_fd(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0long rfds[2048 / (sizeof(long) * CHAR_BIT)] =3D=
 { 0 };<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd_set rfds;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int fd2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int fd;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char buf[BUF_SIZE];<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Test if nfds &gt; 1024.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Make sure ulimit is set correctly (ulimit -n=
 2048).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Open a file, close it and use the closed FD =
in the pselect6 call<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fd2 =3D dup2(wait_fd, 2047);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd2 !=3D 2047) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perror(&quot;dup2&q=
uot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(&quot;/dev/null&quot;, O_RDONLY);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perror(&quot;open&q=
uot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0FD_SET(fd2, (fd_set *) &amp;rfds);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D syscall(SYS_pselect6, fd2 + 1, &amp;rfd=
s, NULL, NULL, NULL, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D close(fd);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perror(&quot;close&=
quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0FD_ZERO(&amp;rfds);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0FD_SET(fd, &amp;rfds);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D syscall(SYS_pselect6, fd + 1, &amp;rfds=
, NULL, NULL, NULL, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 perror(&quot;# psel=
ect()&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;# [pse=
lect] data available\n&quot;);<br>
@@ -471,7 +479,8 @@ void pselect_fd_too_big(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;# [pse=
lect] timeout\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
+error:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
@@ -892,7 +901,7 @@ int main(int argc, const char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 run_working_cases()=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 3:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pselect_fd_too_big(=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pselect_invalid_fd(=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 4:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_ppoll_big();<b=
r>
diff --git a/tests/regression/kernel/test<wbr>_select_poll_epoll b/tests/re=
gression/kernel/test<wbr>_select_poll_epoll<br>
index e01866f..ec034e6 100755<br>
--- a/tests/regression/kernel/test<wbr>_select_poll_epoll<br>
+++ b/tests/regression/kernel/test<wbr>_select_poll_epoll<br>
@@ -126,13 +126,13 @@ function test_timeout_cases()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rm -rf $TRACE_PATH<br>
=C2=A0}<br>
<br>
-function test_big_pselect()<br>
+function test_pselect_invalid_fd()<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TRACE_PATH=3D$(mktemp -d)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SESSION_NAME=3D&quot;syscall_payload&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SYSCALL_LIST=3D&quot;pselect6&quot;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;pselect with a FD &gt; 1023&quot;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0diag &quot;pselect with invalid FD&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 create_lttng_session_ok $SESSION_NAME $TRACE_PA=
TH<br>
<br>
@@ -384,7 +384,7 @@ skip $isroot &quot;Root access is needed. Skipping all =
tests.&quot; $NUM_TESTS ||<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_working_cases<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_timeout_cases<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0test_big_pselect<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0test_pselect_invalid_fd<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_big_ppoll<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_ppoll_overflow<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_pselect_invalid_ptr<br>
diff --git a/tests/regression/kernel/vali<wbr>date_select_poll_epoll.py b/t=
ests/regression/kernel/vali<wbr>date_select_poll_epoll.py<br>
index f4946e7..613cec3 100755<br>
--- a/tests/regression/kernel/vali<wbr>date_select_poll_epoll.py<br>
+++ b/tests/regression/kernel/vali<wbr>date_select_poll_epoll.py<br>
@@ -450,8 +450,8 @@ class Test2(TraceParser):<br>
=C2=A0class Test3(TraceParser):<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self, trace, pid):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().__init__(trace, pid)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.expect[&quot;select_too_big_in<wbr>&quot;=
] =3D 0<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.expect[&quot;select_too_big_ou<wbr>t&quot=
;] =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.expect[&quot;select_invalid_fd<wbr>_in&qu=
ot;] =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.expect[&quot;select_invalid_fd<wbr>_out&q=
uot;] =3D 0<br>
<br>
=C2=A0 =C2=A0 =C2=A0def select_entry(self, event):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timestamp =3D event.timestamp<br>
@@ -466,9 +466,8 @@ class Test3(TraceParser):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_exceptfds_length =3D event[&quot;_except=
fds_length&quot;]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exceptfds =3D event[&quot;exceptfds&quot;=
]<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # make sure an invalid value still produces a =
valid event<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if n =3D=3D 2048 and overflow =3D=3D 0 and _re=
adfds_length =3D=3D 0:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.expect[&quot;select_too_big=
_in<wbr>&quot;] =3D 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if n &gt; 0 and overflow =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.expect[&quot;select_invalid=
_fd<wbr>_in&quot;] =3D 1<br>
<br>
=C2=A0 =C2=A0 =C2=A0def select_exit(self, event):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timestamp =3D event.timestamp<br>
@@ -483,9 +482,9 @@ class Test3(TraceParser):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_exceptfds_length =3D event[&quot;_except=
fds_length&quot;]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exceptfds =3D event[&quot;exceptfds&quot;=
]<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # make sure an invalid value still produces a =
valid event<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # make sure the event has a ret field equal to=
 -EBADF<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ret =3D=3D -9 and overflow =3D=3D 0 an=
d _readfds_length =3D=3D 0:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.expect[&quot;select_too_big=
_ou<wbr>t&quot;] =3D 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.expect[&quot;select_invalid=
_fd<wbr>_out&quot;] =3D 1<br>
<br>
<br>
=C2=A0class Test4(TraceParser):<br>
<span class=3D"m_6919143413702466878HOEnZb"><font color=3D"#888888">--<br>
2.7.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"m_6919143413702466878gmail_signature" data-smartmail=3D"gma=
il_signature"><div dir=3D"ltr"><div><div>Francis Deslauriers</div><div dir=
=3D"ltr">Software developer<div>EfficiOS inc.</div></div></div></div></div>
</div></div>

--001a11373292e6cca7054f44c341--

--===============5206813090916912168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5206813090916912168==--
