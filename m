From: Michael Steppe <msteppe91@gmail.com>
Subject: Current Trace File Location
Date: Tue, 29 Oct 2013 11:59:04 -0400
Message-ID: <CAN7pGtu1BtOibd4nj--7z45ye7QeBHCpCRmavwBL52AnNg-y7g__35013.9965572909$1383062410$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0367448844=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <msteppe91@gmail.com>) id 1VbBhG-0006Rf-6y
	for lttng-dev@lists.lttng.org; Tue, 29 Oct 2013 11:59:16 -0400
Received: by mail-qc0-f174.google.com with SMTP id v1so29379qcw.33
	for <lttng-dev@lists.lttng.org>; Tue, 29 Oct 2013 08:59:04 -0700 (PDT)
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

--===============0367448844==
Content-Type: multipart/alternative; boundary=047d7b6dcbe0c27e1c04e9e34bed

--047d7b6dcbe0c27e1c04e9e34bed
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I am not sure if this is where I ask my questions to the developers but I
thought I'd give it a go.

I am able to create a kernel trace, enable all events for the trace, start,
stop and destroy the trace. But let's say I have two traces running on the
same machine:

[user@localhost ~]$ lttng create trace1
[user@localhost ~]$ lttng create trace2
[user@localhost ~]$ lttng create trace3

As I am sure you know, the .lttngrc file is populated with ONLY the latest
created trace name (trace3).

Now let's say I change my mind after creating these traces and wish to
destroy them all. If I use the destroy command...

[user@localhost ~]$ lttng destroy

...with no argument, it defaults to the .lttngrc file and destroys trace3 as
well as the .lttngrc file. This means that the next time I run lttng
destroy I get the error that it cannot find the .lttngrc file and asks if I
created a session. Well we still have trace1 and trace2 in the background
somewhere because if I try to:

[user@localhost ~]$ lttng create trace1

I get told that there is already a trace with that name.

My question to you is, where are all the traces stored until they are
destroyed? LTT obviously knows that trace1 and trace2 are still "running"
because it won't let me create another with the same name until I destroy
it. I know that I could say:

[user@localhost ~]$ lttng destroy trace1
[user@localhost ~]$ lttng destroy trace2

but I am writing an Eclipse plugin to do this tracing without the terminal
so the trace name will be based off of the time of day the user runs it and
therefore I cannot hardcode the name in.

Is there a "destroy all" command that I am missing?

Thanks!!
Michael

--047d7b6dcbe0c27e1c04e9e34bed
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div><div><div>Hello,<b=
r><br>I am not sure if this is where I ask my questions to the developers b=
ut I thought I&#39;d give it a go.<br><br></div>I am able to create a kerne=
l trace, enable all events for the trace, start, stop and destroy the trace=
. But let&#39;s say I have two traces running on the same machine:<br>
<br></div>[user@localhost ~]$ lttng create trace1<br>[user@localhost ~]$ lt=
tng create trace2<br>[user@localhost ~]$ lttng create trace3<br><br></div>A=
s I am sure you know, the .lttngrc file is populated with ONLY the latest c=
reated trace name (<span style=3D"color:rgb(255,0,0)">trace3</span>). <br>
<br>Now let&#39;s say I change my mind after creating these traces and wish=
 to destroy them all. If I use the destroy command...<br><br></div>[user@lo=
calhost ~]$ lttng destroy<br><br></div>...with no argument, it defaults to =
the .lttngrc file and destroys <span style=3D"color:rgb(255,0,0)">trace3 </=
span>as well as the .lttngrc file. This means that the next time I run lttn=
g destroy I get the error that it cannot find the .lttngrc file and asks if=
 I created a session. Well we still have <span style=3D"color:rgb(255,0,0)"=
>trace1 </span>and <span style=3D"color:rgb(255,0,0)">trace2 </span>in the =
background somewhere because if I try to:<br>
<br>[user@localhost ~]$ lttng create trace1<br><br></div>I get told that th=
ere is already a trace with that name.<br><br></div>My question to you is, =
where are all the traces stored until they are destroyed? LTT obviously kno=
ws that <span style=3D"color:rgb(255,0,0)">trace1 </span>and <span style=3D=
"color:rgb(255,0,0)">trace2 </span>are still &quot;running&quot; because it=
 won&#39;t let me create another with the same name until I destroy it. I k=
now that I could say:<br>
<br>[user@localhost ~]$ lttng destroy trace1<br>[user@localhost ~]$ lttng d=
estroy trace2<br><br>but I am writing an Eclipse plugin to do this tracing =
without the terminal so the trace name will be based off of the time of day=
 the user runs it and therefore I cannot hardcode the name in.<br>
<br></div>Is there a &quot;destroy all&quot; command that I am missing?<br>=
<br></div>Thanks!!<br></div>Michael<br><div><div><div><div><div><div><br><b=
r></div></div></div></div></div></div></div>

--047d7b6dcbe0c27e1c04e9e34bed--


--===============0367448844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0367448844==--
