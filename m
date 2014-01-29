From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: liblttng-ust-cyg-profile.so not found
Date: Wed, 29 Jan 2014 14:26:07 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267DD6EB__42977.254294283$1391005638$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1W8W5l-0005pI-W4
	for lttng-dev@lists.lttng.org; Wed, 29 Jan 2014 09:26:19 -0500
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
Cc: Shariyar <syed.shariyar@gmail.com>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Tue, 28 Jan 2014 11:37:20 -0500
From: Shariyar <syed.shariyar@gmail.com>

> I am trying to collect function entry and exit points in a trace. I  have=
 followed the instructions written on the following man page:
> http://manpages.ubuntu.com/manpages/trusty/man3/lttng-ust-cyg-profile.3.h=
tml.
>
> In my system, UST tracepoint tracing  is working fine and I am able to co=
llect traces with the statically typed tracepoints in the code.
> However, there is no liblttng-ust-cyg-profile.so in my system and I get a=
n error when I execute the following:
>
>      *LD_PRELOAD=3Dliblttng-ust-cyg-profile.so* appname
------------------------------
Date: Tue, 28 Jan 2014 12:29:43 -0500
From: Suchakrapani Datt Sharma <suchakrapani.sharma@polymtl.ca>

> Check if the liblttng-ust-cyg-profile.so is present in system using 'loca=
te'. On my system its in /usr/lib64
> Then give the absolute path -
>*LD_PRELOAD=3D/usr/lib64/liblttng-ust-cyg-profile.so* appname
------------------------------
Date: Tue, 28 Jan 2014 12:32:14 -0500
From: Shariyar <syed.shariyar@gmail.com>

> It is not present in the system even after reinstalling ust libs from PPA.
> I am working on Ubuntu 12.04.1 LTS, 64 bit.
------------------------------
Date: Tue, 28 Jan 2014 12:45:34 -0500
From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>

> On Ubuntu/Debian, there is no "lib64", it's /usr/lib/x86_64-linux-gnu/
>
> If you installed UST from the distro package, it should be at:
> /usr/lib/x86_64-linux-gnu/liblttng-ust-cyg-profile.so.0
>
> (the .so symlink is only installed by the -dev package)
>
> If you installed from source, it would be at:
> /usr/local/lib/liblttng-ust-cyg-profile.so
>
> Quick tip: you can use:
> dpkg -L liblttng-ust0
> to list the files installed by a package.
------------------------------
Date: Tue, 28 Jan 2014 16:19:09 -0500
From: Shariyar <syed.shariyar@gmail.com>

> dpkg -L liblttng-ust0 gives the following; i.e., no liblttng-ust-cyg-prof=
ile.so
>
> /usr/share/man/man3/lttng-ust-cyg-profile.3.gz

   Which package did you install, and whence came it?

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
