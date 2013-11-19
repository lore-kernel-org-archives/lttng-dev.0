From: Michael Steppe <msteppe91@gmail.com>
Subject: Having Trouble with LTTng folders
Date: Tue, 19 Nov 2013 08:43:17 -0500
Message-ID: <CAN7pGttHpT-VA1zvS42CxStVhcRdThMc5HeHG25OGL3hCiL8Vg__27921.1090332412$1384870109$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1951209226=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f44.google.com ([209.85.128.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <msteppe91@gmail.com>) id 1VilaM-0006Pu-Jo
	for lttng-dev@lists.lttng.org; Tue, 19 Nov 2013 08:43:23 -0500
Received: by mail-qe0-f44.google.com with SMTP id ne12so4351824qeb.31
	for <lttng-dev@lists.lttng.org>; Tue, 19 Nov 2013 05:43:17 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1951209226==
Content-Type: multipart/alternative; boundary=001a11c2d758cb644004eb87d83d

--001a11c2d758cb644004eb87d83d
Content-Type: text/plain; charset=ISO-8859-1

Hello!

I am currently running lttng-tools 2.0.4 on CentOS 6.3 (unfortunately I
cannot upgrade either at this time).

I have created a plugin in Eclipse (called LTTng Control) that allows users
to trace without the command line. It is just a simple GUI with buttons
that essentially relate to the system calls in the terminal. One of the
options I have allows users to manually connect, via the IP address, to
another VM to trace remotely on that VM. So far I support RHEL 6.1, 6.3,
6.4, and CentOS 6.3 remote VMs. I have made all the system calls as seen
below, creating each trace in /tmp and calling all lttng calls on that
specific trace:

lttng create TRACE_<date>_<time> -o /tmp/TRACE_<date>_<time>
lttng enable-event -a -k TRACE_<date>_<time>
lttng start TRACE_<date>_<time>
lttng stop TRACE_<date>_<time>
lttng destroy TRACE_<date>_<time>

I then change ownership of each trace folder (and all subfolders) after the
destroy command so that the user who signed in when connecting to the
remote VM now has ownership of the trace and can view and open the trace
files in the LTTng Eclipse Viewer plugin.

This ALL works PERFECTLY on a remote VM where I had the root account
"adduser user". Unfortunately, I need to set up users a little differently
for work...

I have set up another VM that only has a root account. Using Active
Directory, I set up user accounts from my work's development network
(giving everyone here at work the ability to sign in with their usernames
and passwords), meaning root does not have permissions to edit files owned
by these users. Here lies my problem:

Let's say I sign in to the remote VM as user = "Scott". When I try and
attempt to perform the "create" command through my plugin, I get:

An error was encountered on 10.176.15.180 (10.176.15.180)
Host: 10.176.15.180
Command: /usr/bin/lttng create TRACE_111913_082211 -o
/tmp/TRACE_111913_082211
Exit Code: 1
No output stream captured
Error Output:
    Error: Unable to create config file
    Error: Command error

I am assuming it is unable to create the config file because the all the
tracing folders and files are created and owned by root and root does not
have access to write to Scott's home directory, where the config file
should go. The trace is actually created, but not .lttngrc file is created.
If I perform an 'lttng list" in the remote VM (signed in as Scott), I can
see the TRACE_<date>_<time> and that its status is [inactive] (because we
haven't started the trace yet).

My question is this. Is there a way, in this version of LTT, to have the
.lttng and .lttngrc folder/file to be located somewhere else? That way, all
the tracing is done by root and the trace files are stored in /tmp and when
the tracing is finished, root can give Scott ownership of the trace files?

I know that was long and possibly confusing so let me know if you have any
questions. Love your tracing tool by the way!

Thanks!
Michael Steppe

--001a11c2d758cb644004eb87d83d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hello!<br><br></div>I am currently running =
lttng-tools 2.0.4 on CentOS 6.3 (unfortunately I cannot upgrade either at t=
his time).<br><br>I
 have created a plugin in Eclipse (called LTTng Control) that allows=20
users to trace without the command line. It is just a simple GUI with=20
buttons that essentially relate to the system calls in the terminal. One
 of the options I have allows users to manually connect, via the IP=20
address, to another VM to trace remotely on that VM. So far I support=20
RHEL 6.1, 6.3, 6.4, and CentOS 6.3 remote VMs. I=20
have made all the system calls as seen below, creating each trace in=20
/tmp and=20
calling all lttng calls on that specific trace:<br>
<br>
lttng create TRACE_&lt;date&gt;_&lt;time&gt; -o /tmp/TRACE_&lt;date&gt;_&lt=
;time&gt;<br>
lttng enable-event -a -k TRACE_&lt;date&gt;_&lt;time&gt;<br>
lttng start TRACE_&lt;date&gt;_&lt;time&gt;<br>
lttng stop TRACE_&lt;date&gt;_&lt;time&gt;<br>
lttng destroy TRACE_&lt;date&gt;_&lt;time&gt;<br><br></div><div>I then=20
change ownership of each trace folder (and all subfolders) after the=20
destroy command so that the user who signed in when connecting to the=20
remote VM now has ownership of the trace and can view and open the trace
 files in the LTTng Eclipse Viewer plugin.<br>
</div><div><br></div><div>This ALL works PERFECTLY on a remote VM where I
 had the root account &quot;adduser user&quot;. Unfortunately, I need to se=
t up=20
users a little differently for work...<br></div><div><br>I have set up=20
another VM that only has a root account. Using Active Directory, I set=20
up user accounts from my work&#39;s development network (giving everyone=20
here at work the ability to sign in with their usernames and passwords),
 meaning root does not have permissions to edit files owned by these=20
users. Here lies my problem:<br>
<br></div><div>Let&#39;s say I sign in to the remote VM as user =3D &quot;S=
cott&quot;.=20
When I try and attempt to perform the &quot;create&quot; command through my=
=20
plugin, I get:<br><br>An error was encountered on 10.176.15.180 (10.176.15.=
180)<br>
Host: 10.176.15.180<br>Command: /usr/bin/lttng create TRACE_111913_082211 -=
o /tmp/TRACE_111913_082211<br>Exit Code: 1<br>No output stream captured<br>=
Error Output:<br>=A0=A0=A0 Error: Unable to create config file<br>=A0=A0=A0=
 Error: Command error<br>

<br></div><div>I am assuming it is unable to create the config file=20
because the all the tracing folders and files are created and owned by=20
root and root does not have access to write to Scott&#39;s home directory,=
=20
where the config file should go. The trace is actually created, but not=20
.lttngrc file is created. If I perform an &#39;lttng list&quot; in the remo=
te VM=20
(signed in as Scott), I can see the TRACE_&lt;date&gt;_&lt;time&gt; and=20
that its status is [inactive] (because we haven&#39;t started the trace=20
yet).<br>
<br></div><div>My question is this. Is there a way, in this version of=20
LTT, to have the .lttng and .lttngrc folder/file to be located somewhere
 else? That way, all the tracing is done by root and the trace files are
 stored in /tmp and when the tracing is finished, root can give Scott=20
ownership of the trace files?<br>
<br></div><div>I know that was long and possibly confusing so let me know i=
f you have any questions. Love your tracing tool by the way!<br></div><br>T=
hanks!<br></div>Michael Steppe<br></div>

--001a11c2d758cb644004eb87d83d--


--===============1951209226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1951209226==--
