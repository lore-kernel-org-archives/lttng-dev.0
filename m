From: "Thibault, Daniel" <dthibault@drdc-rddc.gc.ca>
Subject: babeltrace output format
Date: Fri, 1 Mar 2013 19:26:57 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD022E1A__22553.5921090797$1362167907$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dthibault@drdc-rddc.gc.ca>) id 1UBVcB-0004RO-Pz
	for lttng-dev@lists.lttng.org; Fri, 01 Mar 2013 14:27:31 -0500
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Painchaud, Frederic" <fpaincha@drdc-rddc.gc.ca>, "Couture,
	Mario" <mcoutur@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

Is anyone else bothered by the slight irregularity of babeltrace's output?

Here is the same trace record printed using various babeltrace settings.  I=
n all cases I used '-f trace:hostname --no-delta', varying only the '-n' pa=
rt:

-n scope
[11:02:08.064705355] edge-vb-u12 exit_syscall: stream.packet.context =3D { =
0 }, stream.event.context =3D { 1, 943, "whoopsie", 943, 109 }, event.field=
s =3D 8
-n payload
[11:02:08.064705355] edge-vb-u12 exit_syscall: { 0 }, { 1, 943, "whoopsie",=
 943, 109 }, { ret =3D 8 }
-n none
[11:02:08.064705355] edge-vb-u12 exit_syscall: { 0 }, { 1, 943, "whoopsie",=
 943, 109 }, 8
-n all
timestamp =3D 11:02:08.064705355, trace:hostname =3D edge-vb-u12, name =3D =
exit_syscall, stream.packet.context =3D { cpu_id =3D 0 }, stream.event.cont=
ext =3D { ppid =3D 1, tid =3D 943, procname =3D "whoopsie", pid =3D 943, pe=
rf_major_faults =3D 109 }, event.fields =3D { ret =3D 8 }

Now compare just the payload part:

-n scope
event.fields =3D 8
-n payload
{ ret =3D 8 }
-n none
8
-n all
event.fields =3D { ret =3D 8 }

It turns out the payload is bracketed by {} except when it has size zero or=
 one and its contents are unlabelled.  Indeed, with an empty payload I can =
get a trailing "{ }" or "" (that is to say, the record ends with a comma) d=
epending on the labelling.  However, notice that for the stream.packet.cont=
ext this does not happen, maybe because the underlying structure has actual=
ly six fields instead of the lone one normally shown (you can get all six p=
rinted using --verbose):

-n scope
stream.packet.context =3D { 0 },
-n payload
{ 0 },
-n none
{ 0 },
-n all
stream.packet.context =3D { cpu_id =3D 0 },
-v
{ timestamp_begin =3D 4196192044293, timestamp_end =3D 4196224429641, conte=
nt_size =3D 2096768, packet_size =3D 2097152, events_discarded =3D 0, cpu_i=
d =3D 0 },

This variability could make babeltrace's text output more difficult to pars=
e than necessary, since one would have to handle the occasionally-disappear=
ing curly brackets.

Is this worth filing a bug over?

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0/ Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
