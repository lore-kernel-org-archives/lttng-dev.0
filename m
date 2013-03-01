From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Need UST for LTTng-tool to build
Date: Thu, 28 Feb 2013 19:21:30 -0500
Message-ID: <512FF48A.7050809__4163.03584720499$1362097348$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UBDjG-0003bj-MC
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 19:21:38 -0500
Received: by mail-ie0-f171.google.com with SMTP id 10so2910876ied.30
	for <lttng-dev@lists.lttng.org>; Thu, 28 Feb 2013 16:21:33 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jon Bernard <jbernard@debian.org>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Jon,

To save you the trouble of trying to find the source of the latest FTBFS
of LTTng-Tools, here's the solution.

You need to apply the commit:

Remove direct dependency of probes on urcu-bp
fd9619bcf98bae43e3418b6c61d2727d49d7d54b

to the lttng-ust package before you can build lttng-tools

Yannick
