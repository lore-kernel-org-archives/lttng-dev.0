From: Glen Keane <glenkeane.94@gmail.com>
Subject: Printing to stdout and stderr from the userspace
	library.
Date: Wed, 4 Feb 2015 15:13:06 +0000
Message-ID: <CAJaGzgusJKn7EPb-XbZCHBSBGVh-Di9kwcLiYKh-uvTdf-NjCw__3630.68768424473$1423062863$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1400097893=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <glenkeane.94@gmail.com>) id 1YJ1dg-0005fE-CE
 for lttng-dev@lists.lttng.org; Wed, 04 Feb 2015 10:13:15 -0500
Received: by mail-wi0-f180.google.com with SMTP id h11so4322766wiw.1
 for <lttng-dev@lists.lttng.org>; Wed, 04 Feb 2015 07:13:06 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1400097893==
Content-Type: multipart/alternative; boundary=f46d04428b86e3b191050e449fa0

--f46d04428b86e3b191050e449fa0
Content-Type: text/plain; charset=UTF-8

Hey Everybody,

I'm currently working on getting Lttng tracepoints into node.js/iojs. iojs
is a downstream fork of node.js, which I personally hope will be merged
back into node.js, which will then include all my tracing work from iojs.
I'm currently having some trouble with lttng userspace library printing to
stdout/stderr from iojs however.

I currently have a pull request issued on the iojs core (
https://github.com/iojs/io.js/pull/702) and this could hopefully mean we
will get lttng tracepoints into the project! :)

I have hit an issue with my pull request, however. If you follow the link
above you can see @bnoordhuis asked me about a test which I had to modify
for this pull request. This particular test passes some variables to a
child process, the child prints the variables to stdout/stderr, and the
parent takes a pipe of the childs stdout/stderr and compares it to an
expected stdout/stderr, and asserts they match. If they don't match, its a
catastrophic failure and that single test fails.

The issue here is that when you spawn a child process in node.js and pass
it a custom ENV variable, the ENV variables available to the child process
will not have access to any of the ENV variables of the parent process.
This means there is no LTTNG_HOME or HOME env variables available to the
child process. This then in turn means that when lttng's userspace library
is instantiated it doesn't have access to either of those variables and
spits out this warning to stderr:

Warning: HOME environment variable not set. Disabling LTTng-UST per-user
tracing.

I accept this warning is warranted, as there is no tracing location
available to the child process so therefore it cannot be traced, but it
means that the test fails, as it does not expect this error to printed to
stderr. I am looking for a way to silence the output of the library so this
test doesn't need to be modified, and so I don't have to implicitly pass a
child process the ENV HOME variable or LTTNG-HOME variable. The ability to
clear all env variables being passed to a child is a design choice which is
acceptable behaviour of io.js.

I did not expect a library to print to stderr/stdout however, and I feel
that this is something that may need to approached and rectified.

Thanks for reading,
Glen Keane.

--f46d04428b86e3b191050e449fa0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey Everybody,<br><br>I&#39;m currently working on getting=
 Lttng tracepoints into node.js/iojs. iojs is a downstream fork of node.js,=
 which I personally hope will be merged back into node.js, which will then =
include all my tracing work from iojs. I&#39;m currently having some troubl=
e with lttng userspace library printing to stdout/stderr from iojs however.=
<br><br>I currently have a pull request issued on the iojs core (<a href=3D=
"https://github.com/iojs/io.js/pull/702">https://github.com/iojs/io.js/pull=
/702</a>) and this could hopefully mean we will get lttng tracepoints into =
the project! :)<br><br>I have hit an issue with my pull request, however. I=
f you follow the link above you can see @bnoordhuis asked me about a test w=
hich I had to modify for this pull request. This particular test passes som=
e variables to a child process, the child prints the variables to stdout/st=
derr, and the parent takes a pipe of the childs stdout/stderr and compares =
it to an expected stdout/stderr, and asserts they match. If they don&#39;t =
match, its a catastrophic failure and that single test fails.<br><br>The is=
sue here is that when you spawn a child process in node.js and pass it a cu=
stom ENV variable, the ENV variables available to the child process will no=
t have access to any of the ENV variables of the parent process. This means=
 there is no LTTNG_HOME or HOME env variables available to the child proces=
s. This then in turn means that when lttng&#39;s userspace library is insta=
ntiated it doesn&#39;t have access to either of those variables and spits o=
ut this warning to stderr:<br><br><font face=3D"monospace, monospace">Warni=
ng: HOME environment variable not set. Disabling LTTng-UST per-user tracing=
.<br></font><br>I accept this warning is warranted, as there is no tracing =
location available to the child process so therefore it cannot be traced, b=
ut it means that the test fails, as it does not expect this error to printe=
d to stderr. I am looking for a way to silence the output of the library so=
 this test doesn&#39;t need to be modified, and so I don&#39;t have to impl=
icitly pass a child process the ENV HOME variable or LTTNG-HOME variable. T=
he ability to clear all env variables being passed to a child is a design c=
hoice which is acceptable behaviour of io.js.<br><br>I did not expect a lib=
rary to print to stderr/stdout however, and I feel that this is something t=
hat may need to approached and rectified.=C2=A0<br><br>Thanks for reading,<=
br>Glen Keane.<br></div>

--f46d04428b86e3b191050e449fa0--


--===============1400097893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1400097893==--
