From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: lttng-dev Digest, Vol 60, Issue 31
Date: Thu, 18 Apr 2013 19:26:20 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D0EEDE__10036.923751659$1366315283$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <mailman.72.1366306995.2121.lttng-dev@lists.lttng.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1USuUL-0006PE-Aq
	for lttng-dev@lists.lttng.org; Thu, 18 Apr 2013 15:27:21 -0400
In-Reply-To: <mailman.72.1366306995.2121.lttng-dev@lists.lttng.org>
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

>   Absolutely: no patching required.

   I decided to find out if the lttng-modules were required at all if one n=
eeds to do only user-space tracing.

   I installed (on an otherwise lttng-virgin system) just the userspace-rcu=
, lttng-ust, and lttng-tools packages.  The lttng commands fail for the usu=
al "can't find /usr/local/lib" reason, so I need to do not:

$ lttng list -u

   but rather

$ LD_PRELOAD=3D/usr/local/lib/liblttng-ctl.so:/usr/local/lib/liblttng-ust-c=
tl.so lttng list -u

   or

$ LD_LIBRARY_PATH=3D/usr/local/lib lttng list -u

   However, once I made the lttng-ust/doc/examples/easy-ust sample, I get a=
 segmentation fault/core dump after starting the trace.

$ LD_LIBRARY_PATH=3D/usr/local/lib lttng create usttrace
Session usttrace created.
Traces will be written in /home/daniel/lttng-traces/usttrace-20130418-150106
$ LD_LIBRARY_PATH=3D/usr/local/lib lttng enable-event -u --all
All UST events are enabled in channel channel0
$ LD_LIBRARY_PATH=3D/usr/local/lib lttng start
Tracing started for session usttrace
$ LD_LIBRARY_PATH=3D/usr/local/lib ./sample
Segmentation fault (core dumped)

   Is this supposed to work or are the kernel modules required even when do=
ing just pure user-space tracing?  I did get a partial trace on disk (just =
the channel0_0 and metadata files, no events in them).

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
