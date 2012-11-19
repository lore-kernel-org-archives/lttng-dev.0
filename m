From: "McDermott, Andrew" <Andrew.McDermott@windriver.com>
Subject: latest version of LTTng UST on Ubuntu 12.04
Date: Mon, 19 Nov 2012 13:54:27 +0000
Message-ID: <7F632A9222059A42AF70FCB7965774AA20987947__5358.51985118843$1353333314$gmane$org@ALA-MBB.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.windriver.com ([147.11.1.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew.McDermott@windriver.com>) id 1TaRo2-0004Pu-9D
	for lttng-dev@lists.lttng.org; Mon, 19 Nov 2012 08:54:34 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id qAJDsS09012346
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <lttng-dev@lists.lttng.org>; Mon, 19 Nov 2012 05:54:28 -0800 (PST)
Content-Language: en-US
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


How often are the LTTng UST packages for Ubuntu updated?

Having done a fresh install I see the version reported as:

  $ lttng version
  lttng version 2.0.1 - Annedd'ale

but looking at the git repo I see there is v2.0.4 tag.  Are these
updates only available if built from source?  In general I was trying to
avoid the daily development versions from:

  https://launchpad.net/~lttng/+archive/daily.

-- 
andy
