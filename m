Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C87C4345F
	for <lttng-dev@archiver.kernel.org>; Thu, 11 Apr 2024 17:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1712857094;
	bh=qK6/BijO1bValshXI2rKXjIqep8EBsbeDBl1U3nF4R8=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=HiZx+nFxgyv9jRfUXo+JN7T9s7dqMOB3PQZMP4KEwVVL3i5Oau7dloUEqvwEAOqVZ
	 gOdvrMN8VbUJagMS4SGtJ2djFYUX1lKTVzFl3zsWHQaG5hJKhUYB//MRmSnHqyE//T
	 mwAqHWUn1dkrfGbZG/qQxJRYOzVtnAVvjC9qu2q//6hAaKH4emwCGxMK3zyccsbmmu
	 Mb01Neo1Q+17RxyyX1lQPo2oAGCd/g9LAoD/KSAOLjwWf7ylFMs2X6qU6WS3v9wHxY
	 qeNR9hoxsSJgIOcHZVeE4Rlf7/QpbBRc4f0oJ/mZ348Bh/BaHTa3FtMZUjJ1EEZAGp
	 QJx563gpAtDbA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VFn3T3cqGz2fR5;
	Thu, 11 Apr 2024 13:38:13 -0400 (EDT)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::223])
 by lists.lttng.org (Postfix) with ESMTPS id 4VFP4v14lpz2d9l
 for <lttng-dev@lists.lttng.org>; Wed, 10 Apr 2024 22:38:06 -0400 (EDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE70160002;
 Thu, 11 Apr 2024 02:37:55 +0000 (UTC)
Message-ID: <dcdc31d82b68d1ecff6555f67b6a7c8f6b7032ad.camel@softwareheritage.org>
To: LTTng development <lttng-dev@lists.lttng.org>
Cc: add-forge-now+981.2T8mQOR3uawEg4qPiymRBTnyh9w@archive.softwareheritage.org
Mail-Reply-To: add-forge-now+981.2T8mQOR3uawEg4qPiymRBTnyh9w@archive.softwareheritage.org, 
 Software Heritage Archival Moderators <archival@softwareheritage.org>,
 LTTng development <lttng-dev@lists.lttng.org>
Mail-Followup-To: add-forge-now+981.2T8mQOR3uawEg4qPiymRBTnyh9w@archive.softwareheritage.org, 
 Software Heritage Archival Moderators <archival@softwareheritage.org>,
 LTTng development <lttng-dev@lists.lttng.org>
Organization: Software Heritage
Date: Thu, 11 Apr 2024 10:37:44 +0800
MIME-Version: 1.0
User-Agent: Evolution 3.50.3-1 
X-GND-Sasl: archival@softwareheritage.org
X-Mailman-Approved-At: Thu, 11 Apr 2024 13:38:11 -0400
Subject: [lttng-dev] Software Heritage archival notification for
 git.liburcu.org
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
From: Paul Wise via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: add-forge-now+981.2T8mQOR3uawEg4qPiymRBTnyh9w@archive.softwareheritage.org,
 Software Heritage Archival Moderators <archival@softwareheritage.org>,
 LTTng development <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello liburcu developers,

The mission of Software Heritage is to collect, preserve and share all
the publicly available source code: https://www.softwareheritage.org

We have received a request to add the forge hosted at the URL below
to the list of software origins that are archived, and it is our
understanding that you are or know the contact person for this forge.

https://git.liburcu.org/

In order to archive the forge contents, we will have to periodically
pull the public repositories it contains and clone them into the
Software Heritage archive. FAQs for our processes are available:

https://docs.softwareheritage.org/user/faq/#add-forge-now
https://www.softwareheritage.org/faq/

Please let us know if there are any issues to consider before
we launch the archival of the public repositories hosted on your
infrastructure. Please use "Reply all" to ensure our system will
process your answer properly.

In the absence of an answer to this message, we will start to archive
your forge in the coming weeks. Only the publicly accessible
repositories will be archived.

Thank you in advance for your help.

Kind regards,
The Software Heritage team

-- 
bye,
pabs

https://wiki.softwareheritage.org/wiki/User:PaulWise
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
