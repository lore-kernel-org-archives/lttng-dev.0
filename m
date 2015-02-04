From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Printing to stdout and stderr from the
	userspace	library.
Date: Wed, 4 Feb 2015 17:11:39 +0000 (UTC)
Message-ID: <1487656020.75537.1423069899682.JavaMail.zimbra__40033.7924519137$1423070016$gmane$org@efficios.com>
References: <CAJaGzgusJKn7EPb-XbZCHBSBGVh-Di9kwcLiYKh-uvTdf-NjCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1795726928=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YJ3UJ-0006Ie-7J
 for lttng-dev@lists.lttng.org; Wed, 04 Feb 2015 12:11:40 -0500
In-Reply-To: <CAJaGzgusJKn7EPb-XbZCHBSBGVh-Di9kwcLiYKh-uvTdf-NjCw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Glen Keane <glenkeane.94@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1795726928==
Content-Type: multipart/alternative;
	boundary="----=_Part_75536_46981267.1423069899681"

------=_Part_75536_46981267.1423069899681
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Glen Keane" <glenkeane.94@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Wednesday, February 4, 2015 10:13:06 AM
> Subject: [lttng-dev] Printing to stdout and stderr from the userspace
> library.

> Hey Everybody,

> I'm currently working on getting Lttng tracepoints into node.js/iojs. iojs is
> a downstream fork of node.js, which I personally hope will be merged back
> into node.js, which will then include all my tracing work from iojs. I'm
> currently having some trouble with lttng userspace library printing to
> stdout/stderr from iojs however.

> I currently have a pull request issued on the iojs core (
> https://github.com/iojs/io.js/pull/702 ) and this could hopefully mean we
> will get lttng tracepoints into the project! :)

> I have hit an issue with my pull request, however. If you follow the link
> above you can see @bnoordhuis asked me about a test which I had to modify
> for this pull request. This particular test passes some variables to a child
> process, the child prints the variables to stdout/stderr, and the parent
> takes a pipe of the childs stdout/stderr and compares it to an expected
> stdout/stderr, and asserts they match. If they don't match, its a
> catastrophic failure and that single test fails.

> The issue here is that when you spawn a child process in node.js and pass it
> a custom ENV variable, the ENV variables available to the child process will
> not have access to any of the ENV variables of the parent process. This
> means there is no LTTNG_HOME or HOME env variables available to the child
> process. This then in turn means that when lttng's userspace library is
> instantiated it doesn't have access to either of those variables and spits
> out this warning to stderr:

> Warning: HOME environment variable not set. Disabling LTTng-UST per-user
> tracing.

> I accept this warning is warranted, as there is no tracing location available
> to the child process so therefore it cannot be traced, but it means that the
> test fails, as it does not expect this error to printed to stderr. I am
> looking for a way to silence the output of the library so this test doesn't
> need to be modified, and so I don't have to implicitly pass a child process
> the ENV HOME variable or LTTNG-HOME variable. The ability to clear all env
> variables being passed to a child is a design choice which is acceptable
> behaviour of io.js.

> I did not expect a library to print to stderr/stdout however, and I feel that
> this is something that may need to approached and rectified.

It makes sense to move the output of this library somewhere else than the console, but where, 
and how could we override the behavior without adding an environment variable, which seems 
to be impossible to use in your use-case ? 

Thoughts ? 

Thanks, 

Mathieu 

> Thanks for reading,
> Glen Keane.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_75536_46981267.1423069899681
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"Glen Keane" &lt;glenke=
ane.94@gmail.com&gt;<br><b>To: </b>lttng-dev@lists.lttng.org<br><b>Sent: </=
b>Wednesday, February 4, 2015 10:13:06 AM<br><b>Subject: </b>[lttng-dev] Pr=
inting to stdout and stderr from the userspace&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;library.<br><div><br></div><div dir=3D"ltr">Hey Everybod=
y,<br><div><br></div>I'm currently working on getting Lttng tracepoints int=
o node.js/iojs. iojs is a downstream fork of node.js, which I personally ho=
pe will be merged back into node.js, which will then include all my tracing=
 work from iojs. I'm currently having some trouble with lttng userspace lib=
rary printing to stdout/stderr from iojs however.<br><div><br></div>I curre=
ntly have a pull request issued on the iojs core (<a href=3D"https://github=
.com/iojs/io.js/pull/702" target=3D"_blank">https://github.com/iojs/io.js/p=
ull/702</a>) and this could hopefully mean we will get lttng tracepoints in=
to the project! :)<br><div><br></div>I have hit an issue with my pull reque=
st, however. If you follow the link above you can see @bnoordhuis asked me =
about a test which I had to modify for this pull request. This particular t=
est passes some variables to a child process, the child prints the variable=
s to stdout/stderr, and the parent takes a pipe of the childs stdout/stderr=
 and compares it to an expected stdout/stderr, and asserts they match. If t=
hey don't match, its a catastrophic failure and that single test fails.<br>=
<div><br></div>The issue here is that when you spawn a child process in nod=
e.js and pass it a custom ENV variable, the ENV variables available to the =
child process will not have access to any of the ENV variables of the paren=
t process. This means there is no LTTNG_HOME or HOME env variables availabl=
e to the child process. This then in turn means that when lttng's userspace=
 library is instantiated it doesn't have access to either of those variable=
s and spits out this warning to stderr:<br><div><br></div><span style=3D"fo=
nt-family: monospace,monospace;" data-mce-style=3D"font-family: monospace,m=
onospace;" face=3D"monospace, monospace">Warning: HOME environment variable=
 not set. Disabling LTTng-UST per-user tracing.<br></span><br>I accept this=
 warning is warranted, as there is no tracing location available to the chi=
ld process so therefore it cannot be traced, but it means that the test fai=
ls, as it does not expect this error to printed to stderr. I am looking for=
 a way to silence the output of the library so this test doesn't need to be=
 modified, and so I don't have to implicitly pass a child process the ENV H=
OME variable or LTTNG-HOME variable. The ability to clear all env variables=
 being passed to a child is a design choice which is acceptable behaviour o=
f io.js.<br><div><br></div>I did not expect a library to print to stderr/st=
dout however, and I feel that this is something that may need to approached=
 and rectified.&nbsp;</div></blockquote><div><br></div><div>It makes sense =
to move the output of this library somewhere else than the console, but whe=
re,<br></div><div>and how could we override the behavior without adding an =
environment variable, which seems<br></div><div>to be impossible to use in =
your use-case ?<br></div><div><br></div><div>Thoughts ?<br></div><div><br><=
/div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><br></=
div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padd=
ing-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoratio=
n:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"=
ltr"><div><br></div>Thanks for reading,<br>Glen Keane.<br></div><br>_______=
________________________________________<br>lttng-dev mailing list<br>lttng=
-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/listinfo/ltt=
ng-dev<br></blockquote><div><br><br></div><div><br></div><div>-- <br></div>=
<div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://w=
ww.efficios.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_75536_46981267.1423069899681--


--===============1795726928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1795726928==--
