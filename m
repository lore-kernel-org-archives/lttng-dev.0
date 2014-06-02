From: David Goulet <dgoulet@efficios.com>
Subject: Re: LTTng 2.5 save/load feature feedback
Date: Mon, 2 Jun 2014 11:50:27 -0400
Message-ID: <20140602155027.GB7936__45197.0877628357$1401724296$gmane$org@thessa>
References: <5388A99A.9000506@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2035357367=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WrUVO-00005A-Ix
 for lttng-dev@lists.lttng.org; Mon, 02 Jun 2014 11:50:40 -0400
In-Reply-To: <5388A99A.9000506@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============2035357367==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30 May (11:54:02), Julien Desfossez wrote:
> Hi,
>=20
> I recently tried the new save/load feature and I have some feedback I'd
> like to share.
>=20
> My understanding was that I could create some kind of profile for
> complex tracing setups. Lttngtop is a good example, because we have a
> specific set of events and contexts to enable (to avoid doing -k -a).
> So as my normal user (part of the tracing group and with a sessiond
> started as root), I created a typical lttngtop session like that :
>=20
> lttng create lttngtop
> lttng enable-event -k
> lttng_statedump_start,lttng_statedump_end,lttng_statedump_process_state,l=
ttng_statedump_file_descriptor,lttng_statedump_vm_map,lttng_statedump_netwo=
rk_interface,lttng_statedump_interrupt,sched_process_free,sched_switch,sche=
d_process_fork
> -s lttngtop
> lttng enable-event -k --syscall -a -s lttngtop
> lttng add-context -k -t pid -t procname -t tid -t ppid -t
> perf:cache-misses -t perf:major-faults -t perf:branch-load-misses -s
> lttngtop
> lttng save lttngtop
>=20
> I then destroyed the session and did
> lttng load lttngtop
>=20
> Everything went fine (except for the already known bug of all the
> contexts information not recorded in the XML file). As expected, the XML
> file was saved in ~/.lttng/sessions/lttngtop.lttng.
>=20
> What surprised me was to see this message when later on I started
> manually a lttng-sessiond as my user (after it had been killed) :
> Error: Failed to load session lttngtop: Tracing the kernel requires a
> root lttng-sessiond daemon, as well as "tracing" group membership or
> root user ID for the lttng client.
> Error: Session load failed: Tracing the kernel requires a root
> lttng-sessiond daemon, as well as "tracing" group membership or root
> user ID for the lttng client.
>=20
> I did not expect that the saved sessions would try to auto load when the
> sessiond was starting. I did not try with system-wide sessions, but
> that's the same, I don't really expect that all sessions to be
> automatically loaded on startup. I think a sysadmin (or even the lttng
> installer) could make some tracing profiles available to the users in
> there so that they can use them when needed.
> Also, the fact that a user sessiond tries to load a session that clearly
> requires a root sessiond is kind of confusing.
>=20
> I can see the value of having auto-loaded sessions, but I think it
> should be configurable, either directly in the XML (just like to
> "started" option) or with sessions saved in a different path (for
> example ~/.lttng/auto-sessions/). Also, I think that our users are never
> really spawning manually a sessiond, so maybe the "lttng load -a" is
> more suited for the auto-loading process.

I agree with you on the auto load issue and that we might want to have
something like that (=E0 la Apache):

~/.lttng/sessions/auto/

Have symlink/copy of the session file that you want loaded automatically
in that directory.

>=20
> So we could maybe add an option to the "lttng save" command that allows
> the user to specify if the session should be auto-loaded.

Yes. Maybe a long --auto or -A ?

> With that in mind, should the users part of the tracing group allowed
> to save auto-loading kernel sessions in the system-wide tracing
> directory, or will they have to ask an admin to manually install their
> profile ?

I would say yes here because one can create a kernel session like you do
with lttngtop, a lot of events/contexts then save it in let say a lttng
session template repository or feed it to an other session daemon on an
other system.

One thing we could do is to be more clever during the load and return an
error directly in the liblttng-ctl instead of the round trip to the
session daemon.

If we agree on the above, opening issues on bugs.lttng.org would be the
next step so we can fix these for 2.5 stable.

Cheers!
David

>=20
> I apologize for not providing this kind of feedback when the RFC was
> posted here, I just realized these usability details when I actually
> experimented the feature.
>=20
> Thanks,
>=20
> Julien
>=20
> _______________________________________________ lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTjJ1DXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02X0sH/jxf4xRxn3tE1P2F0FypwnS1
YEeHGcO1W3qzvm8APEovbhSa+ViypOWT8SlBTEnebgvwmu9NurGA3HKqjbECO+5T
SjU+oiBGb7FF5vaCIIJ745gfUjf0eM2gDnjPTWFLnIsCg2UGyGt3iZpS5/Y/jyah
rMvcxuYn7RHn/PsFVOghA3qqEBrAI2b51m7p/9n2HgyNmeEqSVUVeMnS7V6NyJth
eoAbOm/J272HOdW45VVSdzjpefiZszK/qGsWqmIs0+uaY3FZ62oLSQ7NyxHG7I9x
EsaEkQbG4+etHBLAsVaA8w/IHF8UH11FcFwTEcnehaR3mAvG6To3bBPqYt5xBsE=
=4B7u
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--


--===============2035357367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2035357367==--
