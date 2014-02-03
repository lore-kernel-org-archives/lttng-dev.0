From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Having trouble with LTTng folders
Date: Mon, 3 Feb 2014 15:56:44 +0000 (UTC)
Message-ID: <916022011.18045.1391443004003.JavaMail.zimbra__27452.0869403661$1391443063$gmane$org@efficios.com>
References: <CAN7pGtsavSCJsx7dmHH4_gdAY=qDd6GUjw+tagmftPcYNSZD8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1037090810=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WALt9-0004bU-3o
	for lttng-dev@lists.lttng.org; Mon, 03 Feb 2014 10:56:53 -0500
In-Reply-To: <CAN7pGtsavSCJsx7dmHH4_gdAY=qDd6GUjw+tagmftPcYNSZD8Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Steppe <msteppe91@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1037090810==
Content-Type: multipart/alternative;
	boundary="----=_Part_18044_2122239062.1391443004001"

------=_Part_18044_2122239062.1391443004001
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Michael Steppe" <msteppe91@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Tuesday, November 19, 2013 8:38:53 AM
> Subject: [lttng-dev] Having trouble with LTTng folders

> Hello!

> I am currently running lttng-tools 2.0.4 on CentOS 6.3 (unfortunately I
> cannot upgrade either at this time).

> I have created a plugin in Eclipse (called LTTng Control) that allows users
> to trace without the command line. It is just a simple GUI with buttons that
> essentially relate to the system calls in the terminal. One of the options I
> have allows users to manually connect, via the IP address, to another VM to
> trace remotely on that VM. So far I support RHEL 6.1, 6.3, 6.4, and CentOS
> 6.3 remote VMs. I have made all the system calls as seen below, creating
> each trace in /tmp and calling all lttng calls on that specific trace:

> lttng create TRACE_<date>_<time> -o /tmp/TRACE_<date>_<time>
> lttng enable-event -a -k TRACE_<date>_<time>
> lttng start TRACE_<date>_<time>
> lttng stop TRACE_<date>_<time>
> lttng destroy TRACE_<date>_<time>

> I then change ownership of each trace folder (and all subfolders) after the
> destroy command so that the user who signed in when connecting to the remote
> VM now has ownership of the trace and can view and open the trace files in
> the LTTng Eclipse Viewer plugin.

> This ALL works PERFECTLY on a remote VM where I had the root account "adduser
> user". Unfortunately, I need to set up users a little differently for
> work...

> I have set up another VM that only has a root account. Using Active
> Directory, I set up user accounts from my work's development network (giving
> everyone here at work the ability to sign in with their usernames and
> passwords), meaning root does not have permissions to edit files owned by
> these users. Here lies my problem:

> Let's say I sign in to the remote VM as user = "Scott". When I try and
> attempt to perform the "create" command through my plugin, I get:

> An error was encountered on 10.176.15.180 (10.176.15.180)
> Host: 10.176.15.180
> Command: /usr/bin/lttng create TRACE_111913_082211 -o
> /tmp/TRACE_111913_082211
> Exit Code: 1
> No output stream captured
> Error Output:
> Error: Unable to create config file
> Error: Command error

> I am assuming it is unable to create the config file because the all the
> tracing folders and files are created and owned by root and root does not
> have access to write to Scott's home directory, where the config file should
> go. The trace is actually created, but not .lttngrc file is created. If I
> perform an 'lttng list" in the remote VM (signed in as Scott), I can see the
> TRACE_<date>_<time> and that its status is [inactive] (because we haven't
> started the trace yet).

> My question is this. Is there a way, in this version of LTT, to have the
> .lttng and .lttngrc folder/file to be located somewhere else? That way, all
> the tracing is done by root and the trace files are stored in /tmp and when
> the tracing is finished, root can give Scott ownership of the trace files?

> I know that was long and possibly confusing so let me know if you have any
> questions. Love your tracing tool by the way!

I don't think this old version (2.0.4) allowed that. You will probably need to play with your HOME env. var. 
to put the .lttngrc file elsewhere. We introduced LTTNG_HOME env. var. later, but I don't think it was 
present in 2.0.4. 

Thanks, 

Mathieu 

> Thanks!
> Michael Steppe

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_18044_2122239062.1391443004001
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div><br></div><div><br></div><hr id=
=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5=
px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-de=
coration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><b>Fr=
om: </b>"Michael Steppe" &lt;msteppe91@gmail.com&gt;<br><b>To: </b>lttng-de=
v@lists.lttng.org<br><b>Sent: </b>Tuesday, November 19, 2013 8:38:53 AM<br>=
<b>Subject: </b>[lttng-dev] Having trouble with LTTng folders<br><div><br><=
/div><div dir=3D"ltr"><div><div><div><div><div><div><div><div>Hello!<br><di=
v><br></div></div>I am currently running lttng-tools 2.0.4 on CentOS 6.3 (u=
nfortunately I cannot upgrade either at this time).<br><div><br></div>I hav=
e created a plugin in Eclipse (called LTTng Control) that allows=20
users to trace without the command line. It is just a simple GUI with=20
buttons that essentially relate to the system calls in the terminal. One of=
 the options I have allows users to manually connect, via the IP address, t=
o another VM to trace remotely on that VM. So far I support RHEL 6.1, 6.3, =
6.4, and CentOS 6.3 remote VMs. I=20
have made all the system calls as seen below, creating each trace in /tmp a=
nd=20
calling all lttng calls on that specific trace:<br><br>
lttng create TRACE_&lt;date&gt;_&lt;time&gt; -o /tmp/TRACE_&lt;date&gt;_&lt=
;time&gt;<br>
lttng enable-event -a -k TRACE_&lt;date&gt;_&lt;time&gt;<br>
lttng start TRACE_&lt;date&gt;_&lt;time&gt;<br>
lttng stop TRACE_&lt;date&gt;_&lt;time&gt;<br>
lttng destroy TRACE_&lt;date&gt;_&lt;time&gt;<br><div><br></div></div><div>=
I then change ownership of each trace folder (and all subfolders) after the=
 destroy command so that the user who signed in when connecting to the remo=
te VM now has ownership of the trace and can view and open the trace files =
in the LTTng Eclipse Viewer plugin.<br></div><div><br></div><div>This ALL w=
orks PERFECTLY on a remote VM where I had the root account "adduser user". =
Unfortunately, I need to set up users a little differently for work...<br><=
/div><div><br>I have set up another VM that only has a root account. Using =
Active Directory, I set up user accounts from my work's development network=
 (giving everyone here at work the ability to sign in with their usernames =
and passwords), meaning root does not have permissions to edit files owned =
by these users. Here lies my problem:<br><br></div><div>Let's say I sign in=
 to the remote VM as user =3D "Scott". When I try and attempt to perform th=
e "create" command through my plugin, I get:<br><div><br></div>An error was=
 encountered on 10.176.15.180 (10.176.15.180)<br>
Host: 10.176.15.180<br>Command: /usr/bin/lttng create TRACE_111913_082211 -=
o /tmp/TRACE_111913_082211<br>Exit Code: 1<br>No output stream captured<br>=
Error Output:<br>&nbsp;&nbsp;&nbsp; Error: Unable to create config file<br>=
&nbsp;&nbsp;&nbsp; Error: Command error<br><br></div><div>I am assuming it =
is unable to create the config file because the all the tracing folders and=
 files are created and owned by root and root does not have access to write=
 to Scott's home directory, where the config file should go. The trace is a=
ctually created, but not .lttngrc file is created. If I perform an 'lttng l=
ist" in the remote VM (signed in as Scott), I can see the TRACE_&lt;date&gt=
;_&lt;time&gt; and that its status is [inactive] (because we haven't starte=
d the trace yet).<br><br></div><div>My question is this. Is there a way, in=
 this version of LTT, to have the .lttng and .lttngrc folder/file to be loc=
ated somewhere else? That way, all the tracing is done by root and the trac=
e files are stored in /tmp and when the tracing is finished, root can give =
Scott ownership of the trace files?<br><br></div><div>I know that was long =
and possibly confusing so let me know if you have any questions. Love your =
tracing tool by the way!</div></div></div></div></div></div></div></div></b=
lockquote><div><br></div><div>I don't think this old version (2.0.4) allowe=
d that. You will probably need to play with your HOME env. var.<br></div><d=
iv>to put the .lttngrc file elsewhere. We introduced LTTNG_HOME env. var. l=
ater, but I don't think it was<br></div><div>present in 2.0.4.<br></div><di=
v><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div=
><br></div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5=
px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-de=
coration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div =
dir=3D"ltr"><div><div><div><div><div><div><div><br></div><div><br>Thanks!<b=
r></div><div>Michael Steppe<br></div><div><br></div><br></div><br></div></d=
iv></div></div></div></div><br>____________________________________________=
___<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.=
lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote><div><br><br><=
/div><div><br></div><div>-- <br></div><div><span name=3D"x"></span>Mathieu =
Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"></spa=
n><br></div></div></body></html>
------=_Part_18044_2122239062.1391443004001--


--===============1037090810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1037090810==--
