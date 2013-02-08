From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: lttng, lttng-sessiond and the tracing group
Date: Fri, 8 Feb 2013 22:02:05 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD015C09__254.668729803775$1360361005$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1U3w1q-0006HH-Bn
	for lttng-dev@lists.lttng.org; Fri, 08 Feb 2013 17:02:42 -0500
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
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
Message: 3
Date: Wed, 6 Feb 2013 18:27:24 +0000
Subject: Re: [lttng-dev] lttng, lttng-sessiond and the tracing group

>   This may very well be an "Ubuntism".  All flavours of Ubuntu use a lock=
ed
> root and force all users to systematically use sudo; the su command won't
> go anywhere because there is no root password.  [...] The short and sweet
> of it is that (nearly) all super-user operations under Ubuntu will be con=
ducted
> by a user (with sudo privileges), not by the root account.  Hence the
> shenanigans I ran into.  It sounds like LTTng will have to adjust the way=
 it
> allocates the root .lttngrc path under Ubuntu systems, so that it uses
> /root/.lttngrc instead of ~/.lttngrc
------------------------------

   Follow up:

   Turns out the collision between the root and local daemon copies of .ltt=
ngrc can be avoided by prefixing =

the lttng commands with 'sudo -H' for a default Ubuntu configuration.  Othe=
r sudo configurations may be
susceptible to this problem as well, because the value of the HOME environm=
ent variable when invoking
sudo is decided by the sudo security policy.

   The problem is that sysadmins can set the root HOME to an arbitrary valu=
e for whatever reason, so =

lttng-sessiond should not force its HOME to 'root': that would be bad form.=
  Instead, since the daemons are
communicating with each other, there could be a bit of negotiation.  In a n=
utshell, the root daemon would
veto the launch of a user lttng-sessiond if the latter's HOME matched its o=
wn.  Similarly, if the root lttng-sessiond,
upon launching, discovered a user lttng-sessiond with a coinciding HOME, it=
 could either refuse to launch itself or
pre-empt the user lttng-sessiond (i.e., shut it down).  Either way the user=
(s) would get an appropriate error
message.

   The case where multiple users are assigned a single HOME by the sysadmin=
 would be handled similarly.

   On the other hand, maybe a simpler solution would be to have the .lttngr=
c file's name be suffixed to avoid any
collisions.  The root daemon's .lttngrc would become .lttngrc-root, etc.  I=
 don't think there would be a need to decorate
the 'lttng-traces' folder's name, since the contained traces are already "c=
ollision-proofed" by their timestamp suffixes.

   Does this make sense?

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada / Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
