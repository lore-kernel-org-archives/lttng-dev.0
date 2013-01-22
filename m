From: David Goulet <dgoulet@efficios.com>
Subject: Re: LTTng modules not loading?
Date: Tue, 22 Jan 2013 12:28:03 -0500
Message-ID: <50FECC23.4040207__14817.0737237253$1358875731$gmane$org@efficios.com>
References: <3CA1A65C03C1A34C81BBC6272782E696987933@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Txhdn-0007R7-RW
	for lttng-dev@lists.lttng.org; Tue, 22 Jan 2013 12:28:08 -0500
In-Reply-To: <3CA1A65C03C1A34C81BBC6272782E696987933@valcartierex01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Usually, it's the lttng-sessiond's job to load the kernel modules.

So the quick fix here would be to start a session daemon at boot with of
course root privileges.

Thanks!
David

Thibault, Daniel:
>    My two Ubuntu installations have the same set of LTTng modules and too=
ls (they were all built from the same git.lttng.org packages) but different=
 kernels and installation histories.  The "clean" machine has kernel linux-=
virtual (3.2.0-36-virtual), the other one has linux-generic (3.2.0-35-gener=
ic).  After installing LTTng and rebooting, the clean machine does *not* lo=
ad the lttng kernel modules, while the other one does.  /etc/modules and /e=
tc/modprobe.d are the same, the .ko are present in /lib/modules/<kernel>/ex=
tra in both cases.  The clean machine's lttng kernel modules can be loaded =
using modprobe without demur, so there is no problem there.
> =

>    At first I thought this was because the clean machine had not installe=
d the dkms package yet, but adding it made no difference: the lttng modules=
 do not load.
> =

>    How can I get the clean machine to load the lttng kernel modules at bo=
ot time?
> =

> Daniel U. Thibault
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critica=
l Cyber Security (MCCS)
> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & C=
ountermeasures (SPC)
> 2459 route de la Bravoure
> Qu=E9bec, QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada / Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
