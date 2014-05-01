From: Tony Jones <tonyj@suse.de>
Subject: eclipse stand-alone viewer (RCP) packaged as RPM
Date: Thu, 01 May 2014 15:29:29 -0700
Message-ID: <5362CAC9.5080509__22669.0428251915$1398983450$gmane$org@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <tonyj@suse.de>) id 1WfzTy-0006Tw-0m
 for lttng-dev@lists.lttng.org; Thu, 01 May 2014 18:29:40 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6BCB6AB49
 for <lttng-dev@lists.lttng.org>; Thu,  1 May 2014 22:29:33 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

In case it's remotely useful to anyone else,  I beat my head against a wall for a while but was finally able to package the eclipse standalone viewer (http://lttng.org/eclipse) as an rpm using predefined tarballs rather than maven.  We needed a build that was understandable and most importantly, reproducible.  It's available at: https://build.opensuse.org/package/show/devel:tools:lttng/lttng-trace-viewer

I still need to fix it so that the "about" version displayed matches the rpm version rather than the "rolling" version that the eclipse guys use.

tony
