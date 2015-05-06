From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Added information about PID namespace to tracepoints
Date: Wed, 6 May 2015 20:05:02 +0000 (UTC)
Message-ID: <488257867.44883.1430942701983.JavaMail.zimbra__45160.5405811735$1430942803$gmane$org@efficios.com>
References: <551AC231.102@gmail.com> <55490949.7050903@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1559662342=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Yq5Z0-0001nx-SM
 for lttng-dev@lists.lttng.org; Wed, 06 May 2015 16:05:13 -0400
In-Reply-To: <55490949.7050903@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?Q?S=C3=A9bastien?= Lorrain <sebastien.lorrain01@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1559662342==
Content-Type: multipart/alternative;
	boundary="----=_Part_44882_1940136845.1430942701982"

------=_Part_44882_1940136845.1430942701982
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Patch merged with a few coding style fixes.=20

Thanks!=20

Mathieu=20

----- Original Message -----

> Hello everyone,

> We changed the patch code a bit to include all of the VTIDs of a task nes=
ted
> deep down in an arbitrary level of pid namespace.
> For example, if a task is running inside a container nested in another
> container, our patch will display the TID of the task from the point of v=
iew
> of :

> 1. The root container (or the host)
> 2. The parent container
> 3. The container the task is running into

> We also rebased on master, and everything is running smooth and fine on o=
ur
> test machine (linux 3.19.3).
> It should support down to linux 3.8.1.

> Here is an example of a field :

> sched_process_fork: { cpu_id =3D 0 }, { parent_comm =3D "bash", parent_ti=
d =3D
> 10739, parent_pid =3D 10739, parent_ns_inum =3D 4026532365, child_comm =
=3D "bash",
> child_tid =3D 10968, _vtids_length =3D 3, vtids =3D [ [0] =3D 10968, [1] =
=3D 2658, [2]
> =3D 1265 ], child_pid =3D 10968, child_ns_inum =3D 4026532365 }

> Any comments are greatly appreciated!

> Sebastien & Francis.

> On 03/31/15 11:50, S=C3=A9bastien Lorrain wrote:

> > Hello fellow LTTNG devs,
>=20

> > We are students from Polytechnique Montreal and we are currently workin=
g on
> > an TraceCompass analysis module for Linux containers (LXC/Docker/Etc...=
).
> > The information we track is mostly CPU usage by pid namespace, which wo=
uld
> > allow the identification of CPU-utilization related bottlenecks on a Li=
nux
> > container host.
>=20

> > We tried to come up with targeted information to recreate the container=
/PID
> > namespace tree of a Linux host and we have modified lttng-modules to be
> > able
> > to do so :
>=20
> > https://github.com/Selora/lttng-modules
>=20

> > In our analysis, we try to re-use as many information that was already
> > available in the LTTNG kernel tracer. We build our container/namespace =
tree
> > using the tasks and their parent recursively (using only the
> > pid/vppid/ppid). However, we were unable to have a reliable model witho=
ut
> > some light modifications on some tracepoints.
>=20

> > The modifications to the lttng-modulues where the following:
>=20

> > We added the PID namespace INode (from /proc/PID/ns/pid) to the LTTNG
> > statedump tracepoint.
>=20

> > Also, to track new task/containers that would spawn during the tracing
> > session, we also added multiple fields to the sched_process_fork event =
:
>=20

> > * Added a VTID field for the children task. This is mandatory in our
> > analysis, as we keep track of VTID/TID association.
>=20
> > * Added a parent_ns_inum and child_ns_inum field wich represent the pid
> > namespaces inodes of the parent and child task respectively.
>=20

> > * The parent_ns_inum is "not mandatory" in our analysis, but it keeps
> > things
> > simple as we don't have to track TID from parent containers and it keep=
s
> > the
> > code relatively independant wheter statedump is enabled or not.
>=20
> > * The child_ns_inum IS mandatory, because even if we keep track of the
> > PID/VPID/PPID/VPPID that have spawned, it is possible to "inject" a tas=
k in
> > an already existing namespace without repareting it to the child reaper=
 of
> > the container (this means the task is sent in a namespace, but it is no=
t
> > part of the process tree of the container of that namespace)
>=20

> > We hope to integrate our analysis to TraceCompass soon, and without the
> > modification to the LTTNG tracer approved, we would be unable to procee=
d
> > throught code review.
>=20
> > We would be really grateful to the community if we could have feedback,=
 and
> > we will make every modifications possibles to have our analysis up and
> > working!
>=20

> > The code is supposed to work on kernel version 3.8 through 3.19.
>=20
> > It was tested on 3.18 and 3.19, and I'am going to test it for 3.8 today=
.
>=20

> > Cheers,
>=20
> > Sebastien & Francis.
>=20

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_44882_1940136845.1430942701982
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Patch merged with a few coding s=
tyle fixes.<br></div><div><br></div><div>Thanks!<br></div><div><br></div><d=
iv>Mathieu<br></div><div><br></div><hr id=3D"zwchr"><blockquote style=3D"bo=
rder-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;fon=
t-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetic=
a,Arial,sans-serif;font-size:12pt;" data-mce-style=3D"border-left: 2px soli=
d #1010FF; margin-left: 5px; padding-left: 5px; color: #000; font-weight: n=
ormal; font-style: normal; text-decoration: none; font-family: Helvetica,Ar=
ial,sans-serif; font-size: 12pt;">Hello everyone,<br> <br> We changed the p=
atch code a bit to include all of the VTIDs of a task nested deep down in a=
n arbitrary level of pid namespace.<br> For example, if a task is running i=
nside a container nested in another container, our patch will display the T=
ID of the task from the point of view of :<br><ol><li>The root container (o=
r the host)<br></li><li>The parent container</li><li>The container the task=
 is running into<br></li></ol>We also rebased on master, and everything is =
running smooth and fine on our test machine (linux 3.19.3). <br> It should =
support down to linux 3.8.1.<br> <br> Here is an example of a field<big> </=
big><big>: </big><br> <br> <span style=3D"font-family: Courier New,Courier,=
monospace;" data-mce-style=3D"font-family: Courier New,Courier,monospace;" =
face=3D"Courier New, Courier, monospace">sched_process_fork: { cpu_id =3D 0=
 }, { parent_comm =3D "bash", parent_tid =3D 10739, parent_pid =3D 10739, p=
arent_ns_inum =3D 4026532365, child_comm =3D "bash", child_tid =3D 10968, _=
vtids_length =3D 3, vtids =3D [ [0] =3D 10968, [1] =3D 2658, [2] =3D 1265 ]=
, child_pid =3D 10968, child_ns_inum =3D 4026532365 }</span><br> <br> Any c=
omments are greatly appreciated!<br> <br> Sebastien &amp; Francis.<br> <br>=
 <br><div class=3D"moz-cite-prefix">On 03/31/15 11:50, S=C3=A9bastien Lorra=
in wrote:<br></div><blockquote cite=3D"mid:551AC231.102@gmail.com">Hello fe=
llow LTTNG devs,<br> <br> We are students from Polytechnique Montreal and w=
e are currently working on an TraceCompass analysis module for Linux contai=
ners (LXC/Docker/Etc...). The information we track is mostly CPU usage by p=
id namespace, which would allow the identification of CPU-utilization relat=
ed bottlenecks on a Linux container host.<br> <br> We tried to come up with=
 targeted information to recreate the container/PID namespace tree of a Lin=
ux host and we have modified lttng-modules to be able to do so :<br> <a hre=
f=3D"https://github.com/Selora/lttng-modules" target=3D"_blank" data-mce-hr=
ef=3D"https://github.com/Selora/lttng-modules">https://github.com/Selora/lt=
tng-modules</a><br> <br> In our analysis, we try to re-use as many informat=
ion that was already available in the LTTNG kernel tracer. We build our con=
tainer/namespace tree using the tasks and their parent recursively (using o=
nly the pid/vppid/ppid). However, we were unable to have a reliable model w=
ithout some light modifications on some tracepoints.<br> <span style=3D"tex=
t-decoration: underline;" data-mce-style=3D"text-decoration: underline;"><i=
><br> The modifications to the lttng-modulues where the following:</i></spa=
n><br> <br> We added the PID namespace INode (from /proc/PID/ns/pid) to the=
 LTTNG statedump tracepoint.<br> <br> Also, to track new task/containers th=
at would spawn during the tracing session, we also added multiple fields to=
 the <i>sched_process_fork</i> event :<br><ul><li>Added a VTID field for th=
e children task. This is mandatory in our analysis, as we keep track of VTI=
D/TID association.</li><li>Added a<i> parent_ns_inum</i> and <i>child_ns_in=
um</i> field wich represent the pid namespaces inodes of the parent and chi=
ld task respectively.</li><ul><li>The <i>parent_ns_inum</i> is "not mandato=
ry" in our analysis, but it keeps things simple as we don't have to track T=
ID from parent containers and it keeps the code relatively independant whet=
er statedump is enabled or not.</li><li>The <i>child_ns_inum</i><i> </i>IS =
mandatory, because even if we keep track of the PID/VPID/PPID/VPPID that ha=
ve spawned, it is possible to "inject" a task in an already existing namesp=
ace without repareting it to the child reaper of the container (this means =
the task is sent in a namespace, but it is not part of the process tree of =
the container of that namespace)</li></ul></ul><p>We hope to integrate our =
analysis to TraceCompass soon, and without the modification to the LTTNG tr=
acer approved, we would be unable to proceed throught code review.<br> We w=
ould be really grateful to the community if we could have feedback, and we =
will make every modifications possibles to have our analysis up and working=
!<br></p><p>The code is supposed to work on kernel version 3.8 through 3.19=
.<br> It was tested on 3.18 and 3.19, and I'am going to test it for 3.8 tod=
ay.<br></p><p>Cheers,<br> Sebastien &amp; Francis.<br></p></blockquote><br>=
</blockquote><div><br><br></div><div><br></div><div>-- <br></div><div><span=
 name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficio=
s.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_44882_1940136845.1430942701982--


--===============1559662342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1559662342==--
