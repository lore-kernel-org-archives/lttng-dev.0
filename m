From: David Goulet <dgoulet@efficios.com>
Subject: Re: Trace Streaming problem
Date: Tue, 11 Feb 2014 09:57:13 -0500
Message-ID: <20140211145713.GA7091__8717.34773177213$1392130706$gmane$org@thessa>
References: <CAO_ArvpaU2cGQ+9F=A+vHv9zNupXitvkSCr6RZh0LzTjLj9uMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2024779797=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WDEm3-0002Z9-4x
	for lttng-dev@lists.lttng.org; Tue, 11 Feb 2014 09:57:29 -0500
In-Reply-To: <CAO_ArvpaU2cGQ+9F=A+vHv9zNupXitvkSCr6RZh0LzTjLj9uMA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: kumar s <skumar.m226@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============2024779797==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11 Feb (13:24:15), kumar s wrote:
> Hi,
>=20
> I am trying to start the trace on MIPS board and dump it remotely on PC.
>=20
> The steps i do
> On MIPS board:
> lttng create -U net://192.168.233.207 newsession
>=20
> lttng enable-event lttng_statedump_start -k
>=20
> Error: Event lttng_statedump_start: Unable to connect to lttng-relayd
> (channel channel0, session news)
> Warning: Some command(s) went wrong
>=20
> In lttng-sessiond -vvv log
>=20
> [...]
> DEBUG3 [1918/2019]: Consumer socket created (fd: 30) and added to output
> (in consumer_create_socket() at consumer.c:300)
> DEBUG1 [1918/2019]: Setting relayd for session news (in cmd_setup_relayd()
> at cmd.c:722)
> DEBUG3 [1918/2019]: Relayd connect ... (in relayd_connect() at relayd.c:4=
66)
> PERROR [1918/2019]: connect: Connection refused (in
> lttcomm_connect_inet_sock() at inet.c:253)
> Error: Unable to reach lttng-relayd
> DEBUG1 [1918/2019]: Sending response (size: 16, retcode: Unable to connect
> to lttng-relayd) (in thread_manage_clients() at main.c:3973)
> DEBUG1 [1918/2019]: Clean command context structure (in clean_command_ctx=
()
> at main.c:672)
> DEBUG1 [1918/2019]: Accepting client command ... (in
> thread_manage_clients() at main.c:3837)
>=20
> On the linux pc
> i have started lttng-relayd
>=20
> lttng-relayd -vvv -C tcp://0.0.0.0:1234 -D tcp://0.0.0.0:5678 (as specifi=
ed
> in doc folder of lttng-tools)

The relayd is started with different ports here so the session creation
should also specify those like so:

$ lttng create -U net://192.168.233.207:1234:5678

(or use -C/-D).

David

>=20
>=20
> Unfortunately i get error that lttng-relayd unable to connect. I also tri=
ed
> started lttng-relayd on mips board and running the same, still i get same
> error.
>=20
> Can someone explain steps for lttng trace streaming or how i can dump the
> trace live onto PC.
>=20
> Thank you
> Skumar

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJS+jpJXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02ceoH/26tcMinrLnwB0x3D03CBWVz
vRZr8LScPm5Q5d4vhoRf5omjZC2e+NWtOScah8p2/aVRDUmsHwdDUdz8XPr4Jbai
MatoUr31IKQFVvLAVy2qY4hwAMNhn4jLQHqi6jWgnRXzzxn5XwDHnAZ2tq6i2TTA
l0ZyMWkSdVdWyfICyqf6jCB52wumUSHeZ6Lr6UPQQwHke92m9oT3fHAl0fjM5JvZ
eIvw98R4pUpH7hdPTJtgqSxKcmNu0K+MQ0ypG+NPMTUVDjaQw/MA3qGzYfAHWPaS
ItVmka8YP1hTcocTTcrBy5m6+L89MoOnnpuXzpKhnwSijeOITMUab6x/eY169aw=
=93Jo
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--


--===============2024779797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2024779797==--
