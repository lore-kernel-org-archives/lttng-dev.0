From: dgoulet@efficios.com
Subject: Re: Endless waiting for data availability.
Date: Mon, 24 Mar 2014 11:01:24 -0400
Message-ID: <20140324150124.GB9170__39801.6171217479$1395673377$gmane$org@thessa>
References: <CACQ=--QFo0PzTgOfxDjb4Qc-sxJcMB41u0wxXxchfoT5t-krWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1806594795=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WS6Nc-0003KE-Qi
	for lttng-dev@lists.lttng.org; Mon, 24 Mar 2014 11:01:43 -0400
In-Reply-To: <CACQ=--QFo0PzTgOfxDjb4Qc-sxJcMB41u0wxXxchfoT5t-krWw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Ruslan Uvashev <ruslan.uvashev@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1806594795==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23 Mar (20:45:01), Ruslan Uvashev wrote:
> Hello lttng developers,

Hi Ruslan,

I have to say that you found quite a nice and important bug! :) I can
reproduce it here in no time so can you please open an issue on
bugs.lttng.org in the lttng-tools project and flag it high?

You basically just need to add the steps to reproduce and the version of
tools you are using. I'll link this email in the archive to the issue
you will open.

Big thanks!
David

>=20
> While looking at UST example in  "lttng-ust/doc/examples/easy-ust" i
> noticed that waiting for data availability never ends if tracing has never
> been started for UST.
>=20
> I would like to ask you if it is an issue/bug and if it is need to be fix=
ed?
>=20
> Steps:
> 1) create session
> 2) enable UST event
> 3) DO NOT start tracing
> 4) start application and then stop it
> 5) stop tracing <<< here tracing will never stop.
>=20
> Thoughts:
> This is valid only for UST.
> Kernel is ok because it seems that kernel trace files are opened after
> tracing is started while UST trace files are opened during application
> registration.
>=20
> /*
>  * An empty output file is not valid. We need at least one packet
>  * generated per stream, even if it contains no event, so it
>  * contains at least one packet header.
>  */
> if (stream->output_written =3D=3D 0) {
> pthread_mutex_unlock(&stream->lock);
> goto data_pending;
> }
>=20
>=20
>=20
> logs showing issue:
>=20
> rusty@u:~/code/lttng-tools$ lttng -V
>=20
> lttng (LTTng Trace Control) 2.4.0-rc2 - =C9poque Opaque
>=20
> rusty@u:~/code/lttng-tools$ lttng create
> Session auto-20140323-202015 created.
> Traces will be written in /home/rusty/lttng-traces/auto-20140323-202015
> rusty@u:~/code/lttng-tools$ lttng enable-event sample_component:message -u
> UST event sample_component:message created in channel channel0
> rusty@u:~/code/lttng-tools$ ../lttng-ust/doc/examples/easy-ust/sample
> ^C
> rusty@u:~/code/lttng-tools$ lttng stop
> Waiting for data
> availability.................................................^C
>=20
>=20
>=20
> I added a few printouts to lttng and consumer to understand the issue
> better.
>=20
> traces UST:
>=20
> rusty@u:~/code/lttng-tools$ lttng create
> Session auto-20140323-201048 created.
> Traces will be written in /home/rusty/lttng-traces/auto-20140323-201048
> rusty@u:~/code/lttng-tools$ lttng enable-event sample_component:message -u
> UST event sample_component:message created in channel channel0
> rusty@u:~/code/lttng-tools$ ../lttng-ust/doc/examples/easy-ust/sample
> ^C
> rusty@u:~/code/lttng-tools$ lttng stop
> llm.ret_code =3D 81
> Waiting for data availabilityllm.ret_code =3D 1
> .llm.ret_code =3D 1
> .llm.ret_code =3D 1
> ^C
>=20
>=20
> traces UST from daemon:
>=20
> DEBUG1 [6362/6465]: Processing client command 24 (in process_client_msg()
> at main.c:2703)
> DEBUG1 [6362/6465]: Getting session auto-20140323-201048 by name (in
> process_client_msg() at main.c:2782)
> DEBUG2 [6362/6465]: Trying to find session by name auto-20140323-201048 (=
in
> session_find_by_name() at session.c:169)
> DEBUG3 [6362/6465]: Consumer data pending for id 1 (in
> consumer_is_data_pending() at consumer.c:1083)
> DEBUG1 [6495/6501]: Incoming command on sock (in
> consumer_thread_sessiond_poll() at consumer.c:3068)
> DEBUG1 [6495/6501]: UST consumer data pending command for id 1 (in
> lttng_ustconsumer_recv_cmd() at ust-consumer.c:1177)
> DEBUG1 [6495/6501]: Consumer data pending command on session id 1 (in
> consumer_data_pending() at consumer.c:3491)
> DEBUG1 [6495/6501]: >>> Go over stream_list_ht <<< (in
> consumer_data_pending() at consumer.c:3525)
> DEBUG1 [6495/6501]: >>> stream_try_lock(stream) ret =3D 1 <<< (in
> consumer_data_pending() at consumer.c:3532)
> DEBUG1 [6495/6501]: >>> cds_lfht_is_node_deleted(&stream->node.node) ret =
=3D
> 0 <<< (in consumer_data_pending() at consumer.c:3545)
> DEBUG1 [6495/6501]: >>> !!! stream->output_written =3D=3D 0 !!! <<< (in
> consumer_data_pending() at consumer.c:3553)
> DEBUG1 [6495/6501]: received command on sock (in
> consumer_thread_sessiond_poll() at consumer.c:3084)
> DEBUG1 [6362/6465]: Consumer data is  pending for session id 1 (in
> consumer_is_data_pending() at consumer.c:1119)
> DEBUG1 [6362/6465]: Sending response (size: 16, retcode: Unknown error
> code) (in thread_manage_clients() at main.c:3975)
>=20
>=20
>=20
>=20
> traces kernel:
>=20
> rusty@u:~/code/lttng-tools$ lttng create
> Session auto-20140323-201349 created.
> Traces will be written in /home/rusty/lttng-traces/auto-20140323-201349
> rusty@u:~/code/lttng-tools$ lttng enable-event -a -k
> All Kernel events are enabled in channel channel0
> rusty@u:~/code/lttng-tools$ lttng stop
> llm.ret_code =3D 81
> Waiting for data availabilityllm.ret_code =3D 0
>=20
> Warning: Tracing already stopped for session auto-20140323-201349
>=20
>=20
> traces kernel from daemon:
>=20
> DEBUG1 [6362/6465]: Processing client command 24 (in process_client_msg()
> at main.c:2703)
> DEBUG1 [6362/6465]: Getting session auto-20140323-201349 by name (in
> process_client_msg() at main.c:2782)
> DEBUG2 [6362/6465]: Trying to find session by name auto-20140323-201349 (=
in
> session_find_by_name() at session.c:169)
> DEBUG3 [6362/6465]: Consumer data pending for id 2 (in
> consumer_is_data_pending() at consumer.c:1083)
> DEBUG1 [6576/6582]: Incoming command on sock (in
> consumer_thread_sessiond_poll() at consumer.c:3068)
> DEBUG1 [6576/6582]: Kernel consumer data pending command for id 2 (in
> lttng_kconsumer_recv_cmd() at kernel-consumer.c:850)
> DEBUG1 [6576/6582]: Consumer data pending command on session id 2 (in
> consumer_data_pending() at consumer.c:3491)
> DEBUG1 [6576/6582]: >>> Go over stream_list_ht <<< (in
> consumer_data_pending() at consumer.c:3525)
> DEBUG1 [6576/6582]: received command on sock (in
> consumer_thread_sessiond_poll() at consumer.c:3084)
> DEBUG1 [6362/6465]: Consumer data is NOT pending for session id 2 (in
> consumer_is_data_pending() at consumer.c:1119)
> DEBUG1 [6362/6465]: Sending response (size: 16, retcode: Unknown error
> code) (in thread_manage_clients() at main.c:3975)
>=20
>=20
>=20
> Thank you.
>=20
> -------------------------------------
> Best regards,
> Ruslan Uvashev

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTMEjEXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I029EoH/1IxdcJjnTUuEU5j5vfcguyA
tQzpydylES1u60q4WfGE+Hpk6EvTn10DGMlUbyJ9AF0uptLAdvSOAk7HLqmRTuhQ
qQcrKE6DuNEHdmcuX4S93FYjlVwg9v0PdCHM+ZsZb6NDKVZjCHixh2iT1RBpEc4b
tjFdnuOBCanioHLQY5h+xHQ+mDtf1HmffJNXDhR8HwGiZ1se0G8x6UbkSeH+QZ4Q
/dUiDCXJSztQAsriccCMZJJGD+enEyAOVrzf9p1jJlrCU7tn+2QOQvJ/KphUCQ32
LCxBEyGlNyed23KexRAzDzbn3LCRNP9yxaZjs3VmhLnqDAd1QiM0cnkxlN8zMRY=
=Qmax
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--


--===============1806594795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1806594795==--
