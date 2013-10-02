From: Salman Rafiq <salman.rafiq@esk.fraunhofer.de>
Subject: Reading CTF trace using Babeltrace API
Date: Wed, 2 Oct 2013 18:55:17 +0200
Message-ID: <E537659DE2B2C54EBD9FC9180F059880395D85FEA2__7880.5175646723$1380732997$gmane$org@zulu.esk.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx-relay12-dus.antispameurope.com ([94.100.134.212])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <salman.rafiq@esk.fraunhofer.de>) id 1VRPi2-00071r-Pv
	for lttng-dev@lists.lttng.org; Wed, 02 Oct 2013 12:55:40 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>, "jdesfossez@efficios.com" <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Dear LTTngers,

I would like to ask few questions related to the API's for reading CTF trac=
es.

1.  Is there any way to read CTF metadata independently, like we have certa=
in API's to read the events.

2. There are certain scopes defined in ctf/events.h like:
	BT_TRACE_PACKET_HEADER          =3D 0,
	BT_STREAM_PACKET_CONTEXT        =3D 1,
	BT_STREAM_EVENT_HEADER          =3D 2,
	BT_STREAM_EVENT_CONTEXT         =3D 3,
	BT_EVENT_CONTEXT                =3D 4,
	BT_EVENT_FIELDS                 =3D 5,

I could not figure out the way to ready the fields 'id' and 'stream_id', fo=
r a particular event while iterating through the trace.
Though I can ready the event name using an API and fields using BT_EVENT_FI=
ELDS as a scope.
For e.g. consider the =


event {
	name =3D sched_migrate_task;
	id =3D 1;
	stream_id =3D 0;
	fields :=3D struct {
		integer { size =3D 8; align =3D 8; signed =3D 1; encoding =3D UTF8; base =
=3D 10; } _comm[16];
		integer { size =3D 32; align =3D 8; signed =3D 1; encoding =3D none; base=
 =3D 10; } _tid;
		integer { size =3D 32; align =3D 8; signed =3D 1; encoding =3D none; base=
 =3D 10; } _prio;
		integer { size =3D 32; align =3D 8; signed =3D 1; encoding =3D none; base=
 =3D 10; } _orig_cpu;
		integer { size =3D 32; align =3D 8; signed =3D 1; encoding =3D none; base=
 =3D 10; } _dest_cpu;
	};
};


Any help or suggestion related to this issue will be really appreciated.
Thanks!

Regards,
Salman

--
Salman Rafiq
Gesch=E4ftsfeld Industrial Communication
Fraunhofer-Institut  f=FCr Eingebettete Systeme und Kommunikationstechnik E=
SK

Hansastra=DFe 32 | 80686 M=FCnchen
Telefon, Fax:=A0 +49 89 547088-356 | +49 89 547088-221
E-Mail:=A0=A0 salman.rafiq@esk.fraunhofer.de
=A0 =

Internet: =

http://www.esk.fraunhofer.de
http://www.twitter.com/FraunhoferESK
