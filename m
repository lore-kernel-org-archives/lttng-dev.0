From: David Goulet <david.goulet@polymtl.ca>
Subject: Re: Module lttng_tracer not found.
Date: Mon, 30 Jul 2012 10:18:58 -0400
Message-ID: <501697D2.1000401__46216.330145444$1343657966$gmane$org@polymtl.ca>
References: <CABy43G956NYAU4MG9p32+17jwJt8-6TZsdP9xysNs63CGw0hbg@mail.gmail.com>
	<50169737.5010805@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <david.goulet@polymtl.ca>) id 1SvqoI-0003cl-39
	for lttng-dev@lists.lttng.org; Mon, 30 Jul 2012 10:19:02 -0400
In-Reply-To: <50169737.5010805@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org, Rui Han <r.han@umiami.edu>
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

And I would also make sure you start the lttng session daemon as root.

David

On 30/07/12 10:16 AM, Alexandre Montplaisir wrote:
> Hi,
> 
> What steps did you use to install LTTng?
> 
> Also can you please paste the output of: $ apt-cache policy
> lttng-modules-dkms
> 
> 
> Thanks,
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJQFpfSAAoJEELoaioR9I02j24H/1trzQRWn9nh6EPiEZhCbVos
DYc3t6Qa56S66UWbTPZp0TpBSIqpw27gDMyeavKIe5CmsSfIvN5XqNgBAa+aX47m
pO+sJ6jqAARwZjXoowJPgwivifM6qnDYDAAUmrvjjcqfC+4IMpemIdRNZzhUGbm/
GRHOgiDM4g8VO55LODUP/FUBtKlbZsWmJ95zxaDGYo1ZAszLbCwDSp++Nhvg0Yzi
fnyj16ajoZdHnTiarK5ymVqeDE/1SX9fiWUWQvTysnz/EE5niaEtuWa7pRFs/ISq
042YBw0oS8afZarPLvIeKoPB3Dr4379yEWg88qH5lYfzvNicn+ZKUHoEyAu/FcY=
=TX+s
-----END PGP SIGNATURE-----
