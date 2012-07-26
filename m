From: David Goulet <dgoulet@efficios.com>
Subject: Re: Question about lttng daemons
Date: Thu, 26 Jul 2012 11:02:01 -0400
Message-ID: <50115BE9.6000106__1970.8618325696$1343315084$gmane$org@efficios.com>
References: <5010FFA8.9000706@emc.com> <5011570E.3060200@voxpopuli.im>
	<50115A3F.5010402@efficios.com> <50115B54.60909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1SuPZl-0004Bh-At
	for lttng-dev@lists.lttng.org; Thu, 26 Jul 2012 11:02:05 -0400
In-Reply-To: <50115B54.60909@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512



Yannick Brosseau:
> 
> 
> 
>>> We don't ship an example in the source tree, since this is
>>> usually distro-specific, but for reference you can look at the
>>> Upstart script that is available in the Ubuntu package:
>>> 
> http://bazaar.launchpad.net/~ubuntu-branches/ubuntu/quantal/lttng-tools/quantal/view/head:/debian/lttng-tools.lttng-sessiond.upstart
>
> 
> 
>> We could maybe provide this upstart script in extras/ ?
> 
> Yes, probably, with also the systemd script and the old style 
> initscript. (I've made both)

Great! Send me that as a patch or pull request, I'll be glad to merge
that!

David

> 
> 
> _______________________________________________ lttng-dev mailing
> list lttng-dev@lists.lttng.org 
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQEVvpAAoJEELoaioR9I028VsIALVpAuI7hzHHrNjNHTLdGJBy
eTg+tTN2EpWRg+nBAYTWBHfrY+ZYmzdvl2gaXNDTzJm7nMTKEzdYbgIAkYH5FwM6
2Mi4eg8oKC96wnEisEW+328aI17FIevclapHv7Ky816g6YFSnJ/L5Rbu/VRoJFoU
QMY+cINDt9Sbx0y4heLRYED9pEFBu2PMfmf3RVXh76A/J0vcbWB8u9Pmi9GCloEI
dKGURUbXhLVb9WxoJI2zosmYyJWwe6b2o+xA98wvFx+MYpVOGC4t3aOWb1Zra0dL
rddQPo+XuM2ldDVn89Qt45c2KXouTk+1W0CjTm5ffpZMPoioGkvob5cC3aDcFFk=
=NuDF
-----END PGP SIGNATURE-----
