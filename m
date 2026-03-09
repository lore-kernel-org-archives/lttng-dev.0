Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1FBF4181F
	for <lttng-dev@archiver.kernel.org>; Mon,  9 Mar 2026 17:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fV3Tt705Jz1ZP7
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1773076338;
	b=NpoRM0Y/ocM1kMZzh5OAvspFAiPsMQnMrC6SDoTP0f1Wt4ITtQpJFTwdXr3nYLErE6Rm
	 MuXkh2+uPTAAixumS806eU04ASel1w2pZEU+5aMiuDxXh5VPSce3fqRkFNkwy7aOKqab5
	 9LUBSY6ZMHgvnSDqtHM1IDQGXsKooY4vcK4Hkpk7fc41JYuUr8g7phXHwJj/36U4J6ZkR
	 qVLROBPd/Bn1ymiklKY+ysrHUiUrXTTTjdAZ8lE6EDPNSdvWJ+MMRrZWT2gBJFi46F3dE
	 oreC04J8xgYWUYVdCzkJGT1PSeeJwGHk4kY4711AkRuNi3l2ISkRfaXOb7nsedgoTzg==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1773076338;
	h=DKIM-Signature:Date:To:Subject:Message-ID:MIME-Version:From:From;
	bh=IlEKOdZxkPK6Jfoqpr1lHjVxxdyN6pdEohm/GS+VkBI=;
	b=Rk7O6ttnUGExi74H+C8w+0mKQlHwv2Gx1S+xks6ItA9Ry8JcXOzoeVDHuwboG16LsqmL
	 qgkxQo7D5ypZ+ynG1IkDjJ5wvFEVsCrlxbNHS2bA2QlQJscqbUlNGQUAAVQU8lfRUtNQy
	 Ddy9c+91HDmvp5BnmVoslTpmdnSJPRO6h3jpjuOKqRtBHyrfUyA8NYV9JUk9X+U3aQrb+
	 J2ulcPjePdHWufn/kPZ05PAKf2cPUuvShZcXW1ZaIj6BdNY2C//152FKL1Gsyx/diOzq2
	 //ndJiN7gFxegX4yNCDMLkLg8VRg09LChBxBWwKBnu6HcZEWhHNgXPkYLvgKTd0SUHg==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fV3Tt705Jz1ZP7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1773076338;
	bh=IlEKOdZxkPK6Jfoqpr1lHjVxxdyN6pdEohm/GS+VkBI=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=H40ZTQQgAa0dQOf7BbpTT13pq7pzySW0G5FsXYdr4YHykmkpeZIsgsqHbJfY+pVmS
	 tfUx4ISbbXQuNfLLQwNchvj+ozZt0RjwZGbGHilJymss3PQa6SMwZ+uXZqYQ315/c1
	 ZScOrMOy+ZGunHHwWRN1jMON9CLTEbmcDciamLlSen2L6HqOCVQ4c81lRVdBW5s9+Q
	 lrMUe4eqPbO3ATKdkYKXOT/iJnuJTFH+HUrvXHLWfnEqfYyphaIEOPwlu0h9zlwQvm
	 ecSH2UjiOGj7X3+8K5E+q6Y+WGdQosnSIZRgGsPeW33vN0/stVZtIEuAYWHX+C6Vrs
	 Xk5PdDhjBWw2A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4fV3Tt705Jz1ZP7;
	Mon,  9 Mar 2026 13:12:18 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fV3Ts67PBz1Z6Q
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fV3Ts67PBz1Z6Q
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 by lists.lttng.org (Postfix) with ESMTPS id 4fV3Ts67PBz1Z6Q
 for <lttng-dev@lists.lttng.org>; Mon,  9 Mar 2026 13:12:17 -0400 (EDT)
Received: from authenticated user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2) (envelope-from <sanvila@debian.org>)
 id 1vze9Q-002N4V-BX
 for lttng-dev@lists.lttng.org; Mon, 09 Mar 2026 17:12:16 +0000
Date: Mon, 9 Mar 2026 18:12:14 +0100
To: lttng-dev@lists.lttng.org
Subject: Re: Build-time tests fail if machine has a single CPU
Message-ID: <aa7_bv8CMRlfeIFH@nuc>
References: <aa7-8LHGez9Bi0UQ@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa7-8LHGez9Bi0UQ@nuc>
X-Debian-User: sanvila
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Santiago Vila via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Santiago Vila <sanvila@debian.org>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

I forgot one detail which might help to debug the issue:

This started to happen in version 2.14.0.
Version 2.13.15 worked ok.

Thanks.
