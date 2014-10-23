From: David Goulet <dgoulet@efficios.com>
Subject: Re: health check and relaunch of lttng daemons
Date: Thu, 23 Oct 2014 09:24:51 -0400
Message-ID: <20141023132451.GC10437__47633.2477563576$1414070746$gmane$org@thessa>
References: <CAM5kDqzEEKLhpyWuU3+41AJO4wPdKoCyR-YSVnLXtxD1HxfdUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0961642511=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XhINw-0001jC-1W
 for lttng-dev@lists.lttng.org; Thu, 23 Oct 2014 09:25:01 -0400
In-Reply-To: <CAM5kDqzEEKLhpyWuU3+41AJO4wPdKoCyR-YSVnLXtxD1HxfdUQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============0961642511==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23 Oct (12:37:40), Anand Neeli wrote:
> Hi All,
> I have few queries related to notifications when lttng daemons die and
> their spawning and health-check
>=20
> - When relayd dies then sessiond gets error of connection reset, but it
> doesnt try to reconnect to relayd again. It just lies on system without
> being functional.
>=20
> - on a system with multiple nodes, relayd can be spawned on any node. Is
> there a way for the sessiond to discover or get relayd IP-address. (Again
> in case relayd dies and gets spawned on different node, then sessiond has
> to discover and re-connect)

No there is no discovery mechanism of relayd. I know that it has been
worked on a while ago but was more of a school project.

>=20
> - How is the health_check used. Is it deprecated? coz in lttng.h i see
> extern LTTNG_DEPRECATED("This call is now obsolete.")
> int lttng_health_check(enum lttng_health_component c);

Please see lttng/health.h for the API.

>=20
> If health_check can be used for relayd and sessiond?
> Can anyone provide more pointers or example code for health check?

It can be used on the three daemon we have, sessiond, consumerd and
relayd. A good example would be the health test that you can find here:

=2E/tests/regression/tools/health/health_check.c

>=20
> - it becomes really important to get notification/signal from relayd, so
> that software can be added to respawn sessiond.
> please let me know if there is anyway of doing this.

Not sure to fully understand what you want here. You are looking for a
way to detect relayd health so you can respawn a sessiond?

Note that if the relayd dies, the current session using it will NOT try
to reconnect. However, if you create a new session on the sessiond with
a URL pointing to a working relayd, everything should work. No need to
respawn a sessiond. You can simply destroy the session for which the
relayd died and create a new one with the new URL.

Cheers!
David

>=20
>=20
> Thanks,
> Anand Neeli
>=20
>=20
>=20
>=20
> On Tue, Oct 21, 2014 at 12:10 AM, Anand Neeli <anand.neeli@gmail.com> wro=
te:
>=20
> > one more point:
> > if there is a way to kill/exit sessiond on a connection reset then will=
 be
> > easier to re-launch it again
> >
> > wondering if anything of that sort can be done
> >
> > Thanks,
> > Anand Neeli
> >
> > On Tue, Oct 21, 2014 at 12:02 AM, Anand Neeli <anand.neeli@gmail.com>
> > wrote:
> >
> >> Hi All,
> >> if relayd gets killed i see there is connection reset which happens at
> >> client.
> >> Is there a way to relaunch the sessiond/consumerd on a connection rese=
t?
> >>
> >> can some hooks be added or helper application be written to relaunch
> >> sessiond in case exit of relayd or any other connection reset?
> >>
> >> Thanks,
> >> Anand Neeli
> >>
> >
> >

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBCABmBQJUSQGjXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02lokH/2fe90ATOOUAkhpfKwOq/Vqw
q3BV42L9XtGg6L3qihuNr18R2LqWK6tT1I2/UjZulPz+03tcluxhdfUG85a5dUFg
+d4r1aGm4wxxLDmRrmEkoL/TTl7BfclVdOGT3RYmSb+nNeCqYMjHAY+izjbYgGev
kMylYR/2fsS7k4WF6RBH+gC/OaKsan4bd8+zditqvhiPqR8PAuusqnhnyDhyqkk+
bBMKZVvXyynHx2lGHaJZhl+hM/v7mPeoLt1HeqeMv+hX86gwTxWntvg0oV+EV3XI
Q3Rbn5p5ErZnkA//y++CF9zKSWSF4ubTWV/z2z+8HiMsV8vsKSPkIShvuwXaOdM=
=tHo+
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--


--===============0961642511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0961642511==--
