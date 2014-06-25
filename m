From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: LTTng 2.5 save/load feature feedback
Date: Wed, 25 Jun 2014 16:03:28 -0400
Message-ID: <53AB2B10.6060005__45690.2057900608$1403726669$gmane$org@efficios.com>
References: <5388A99A.9000506@efficios.com> <20140602155027.GB7936@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0481514464=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1WztPy-000242-OV
 for lttng-dev@lists.lttng.org; Wed, 25 Jun 2014 16:03:45 -0400
In-Reply-To: <20140602155027.GB7936@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0481514464==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uGBORRjHxxgK6wlWcEDejsuBLkvxugOFd"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uGBORRjHxxgK6wlWcEDejsuBLkvxugOFd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14-06-02 11:50 AM, David Goulet wrote:
> On 30 May (11:54:02), Julien Desfossez wrote:
>> Hi,
>>
>> I recently tried the new save/load feature and I have some feedback I'=
d
>> like to share.
>>
>> My understanding was that I could create some kind of profile for
>> complex tracing setups. Lttngtop is a good example, because we have a
>> specific set of events and contexts to enable (to avoid doing -k -a).
>> So as my normal user (part of the tracing group and with a sessiond
>> started as root), I created a typical lttngtop session like that :
>>
>> lttng create lttngtop
>> lttng enable-event -k
>> lttng_statedump_start,lttng_statedump_end,lttng_statedump_process_stat=
e,lttng_statedump_file_descriptor,lttng_statedump_vm_map,lttng_statedump_=
network_interface,lttng_statedump_interrupt,sched_process_free,sched_swit=
ch,sched_process_fork
>> -s lttngtop
>> lttng enable-event -k --syscall -a -s lttngtop
>> lttng add-context -k -t pid -t procname -t tid -t ppid -t
>> perf:cache-misses -t perf:major-faults -t perf:branch-load-misses -s
>> lttngtop
>> lttng save lttngtop
>>
>> I then destroyed the session and did
>> lttng load lttngtop
>>
>> Everything went fine (except for the already known bug of all the
>> contexts information not recorded in the XML file). As expected, the X=
ML
>> file was saved in ~/.lttng/sessions/lttngtop.lttng.
>>
>> What surprised me was to see this message when later on I started
>> manually a lttng-sessiond as my user (after it had been killed) :
>> Error: Failed to load session lttngtop: Tracing the kernel requires a
>> root lttng-sessiond daemon, as well as "tracing" group membership or
>> root user ID for the lttng client.
>> Error: Session load failed: Tracing the kernel requires a root
>> lttng-sessiond daemon, as well as "tracing" group membership or root
>> user ID for the lttng client.
>>
>> I did not expect that the saved sessions would try to auto load when t=
he
>> sessiond was starting. I did not try with system-wide sessions, but
>> that's the same, I don't really expect that all sessions to be
>> automatically loaded on startup. I think a sysadmin (or even the lttng=

>> installer) could make some tracing profiles available to the users in
>> there so that they can use them when needed.
>> Also, the fact that a user sessiond tries to load a session that clear=
ly
>> requires a root sessiond is kind of confusing.
>>
>> I can see the value of having auto-loaded sessions, but I think it
>> should be configurable, either directly in the XML (just like to
>> "started" option) or with sessions saved in a different path (for
>> example ~/.lttng/auto-sessions/). Also, I think that our users are nev=
er
>> really spawning manually a sessiond, so maybe the "lttng load -a" is
>> more suited for the auto-loading process.
>=20
> I agree with you on the auto load issue and that we might want to have
> something like that (=E0 la Apache):
>=20
> ~/.lttng/sessions/auto/
>=20
> Have symlink/copy of the session file that you want loaded automaticall=
y
> in that directory.
Yes, that would be a clean approach.

>>
>> So we could maybe add an option to the "lttng save" command that allow=
s
>> the user to specify if the session should be auto-loaded.
>=20
> Yes. Maybe a long --auto or -A ?
Yes.

>> With that in mind, should the users part of the tracing group allowed
>> to save auto-loading kernel sessions in the system-wide tracing
>> directory, or will they have to ask an admin to manually install their=

>> profile ?
>=20
> I would say yes here because one can create a kernel session like you d=
o
> with lttngtop, a lot of events/contexts then save it in let say a lttng=

> session template repository or feed it to an other session daemon on an=

> other system.
>=20
> One thing we could do is to be more clever during the load and return a=
n
> error directly in the liblttng-ctl instead of the round trip to the
> session daemon.
>=20
> If we agree on the above, opening issues on bugs.lttng.org would be the=

> next step so we can fix these for 2.5 stable.
Bug created here :
https://bugs.lttng.org/issues/812

Thanks,

Julien

>=20
> Cheers!
> David
>=20
>>
>> I apologize for not providing this kind of feedback when the RFC was
>> posted here, I just realized these usability details when I actually
>> experimented the feature.
>>
>> Thanks,
>>
>> Julien
>>
>> _______________________________________________ lttng-dev mailing list=

>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--uGBORRjHxxgK6wlWcEDejsuBLkvxugOFd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTqysXAAoJECu/boitG9wreb4P+QFyZWjFmRLgNzoILguqsxBI
JrsJZOiVBycUuoQkQsY6VEDx1GbpP/1VYGQSbn8XT+hNaANeU6y7naYkFQg7b23Q
IaidxkDqH9Cbf5PnJgTKHbEiRKY5mj7DFZAE3Ieu0NK9TbMWhhjcsv/iW4l9LUuX
IClzaLH2Yggc5/6pjbcM3hJADRoiwu9eUi8VjM67WWCDUpPjLORJjEMshIvloBUK
JCfEp02UgTyms4vIheRWf/oYV+EY7uqux4fboZWwjUONyJmzpvXAN7O/J4sOkhme
b245kORHXYVNEaYSJIHoutOt7MB+9Ey/m4yLCtJ7fjgVhZ95VPd/D7P+hL9Agl5C
KHHDvsMDzuhNF0dVUTSVXNBt++okYvOzS28xlRePPSUA6xWHFUseuzJSAq+eLni5
fwiK3xJuBlN3M1ye8d3bt5FRGUuOkKB1LFME6F/hqFqgE1coHMvQQ/T0T4JHzPaR
HqMnn0MOTSi6zLDU+2bmbU3663dvcyOt2hFzpAug9z7gleQRs2kdNMch5MACuAT7
HUjsOKPpjsMPXYxdc0WuA4DpEiQHSgQyaoSVcBGFPnaTfD2A3q4bNdqa/ZBhbSwL
jQKh1pf/+f58+UJzBe1rD5eEkwjb4acmO6XdqhVdsG68M4LJ6PouTn7qr1fy6GMa
hqNxlwXJDiHh8MwXdydd
=p2ls
-----END PGP SIGNATURE-----

--uGBORRjHxxgK6wlWcEDejsuBLkvxugOFd--


--===============0481514464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0481514464==--
