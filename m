Return-Path: <SRS0=H/kz=E7=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8454AC56201
	for <lttng-dev@archiver.kernel.org>; Wed, 25 Nov 2020 08:31:52 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B23F206F9
	for <lttng-dev@archiver.kernel.org>; Wed, 25 Nov 2020 08:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="tmQN5SCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B23F206F9
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CgvJ22Rt9z1Ntk;
	Wed, 25 Nov 2020 03:31:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1606293108;
	bh=jAryJCIfRAur+xRVPDpDLPLZx6C4a1ulCdFm9f+ZEns=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=tmQN5SCOOjPdWkkGEM5G0ahReDazsnQQmyU/qA2g+b7R+KrOVZf6C+MW11nEqkdTB
	 YZrBggOvIpxI1YmZ+xBmRm9j7j93C/SyLqqw1n/Gy9N05KD3f2zvo3pmbgn4fJIHnv
	 sgi4HKNdO+RETKD07TO9ezsctsc0Yjy3dN/DU6QZbtzu9DxljL7FWtHFlK6Viw06GW
	 rn0WNC5rap/LKPwrs8HkW8Z1RruZkcb/kJXDrr2ZEuY3pUzFyOXVNohq+kjxrgI+6j
	 mhcuXNaAMP3FfgaXlWm7xe63uUFN81Ye21g9w/ZwdYooRi9GXkWBjYmO0uIC4pIqkt
	 xvwYZRRqd5EZw==
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 by lists.lttng.org (Postfix) with ESMTPS id 4CgvJ00lX0z1NWt
 for <lttng-dev@lists.lttng.org>; Wed, 25 Nov 2020 03:31:43 -0500 (EST)
Received: by mail-lj1-x244.google.com with SMTP id z1so1394379ljn.4
 for <lttng-dev@lists.lttng.org>; Wed, 25 Nov 2020 00:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5gXuL+zf7x1y+R3fPSM+xWj1LoZBxmpbgCqTszrLkrY=;
 b=JAwAgTB5wvjhZ+zT8pmCDAy4Elqt77PS7nx7urAWGto6J2VwpD8dRzm6s9rRkcrRom
 f8XKisdolEdxawF8hq05du5xHzRGCIxpqRCSRfH781tz2OlnijxBh9Q1MdjzH9mQ/pWZ
 c4CeefaBGEfVMOywTUCemtlsiO62J9V8y/olWiikzlqE5jYbXoMSWttxN2pCIWgLo5mX
 CB4oEH/vV0koS/3fQwKw6YvJDpO+GArkjbjQqsA6/ihNPLF0JcxeVk3tHWQ7rCpFuA9f
 2vwocVNTbRrSSEdmnFly31Dc+KOhgIs2LkrC0zJFxKwxjXxHkQd8gX5ucN/Xkm7mpfWS
 Gxiw==
X-Gm-Message-State: AOAM530aoiwgmqEKc8yyVlsgPxorm6LnFo8bjIBswzmNvZ+V+MEBbGG3
 Moq/4OsYhXJmKKAPmhNkYR43AJps2jb6ew==
X-Google-Smtp-Source: ABdhPJzE414JUZ74kjDHT1zlRdG6DtNHWXcI5lhOsXPRyEQzfxL8OpauRYJDOG/1oKC7SjmLAG0seA==
X-Received: by 2002:a2e:96d7:: with SMTP id d23mr954406ljj.413.1606293101787; 
 Wed, 25 Nov 2020 00:31:41 -0800 (PST)
Received: from arn-awallin-linux-l5.corp.ad.wrs.com
 (h-98-128-229-195.NA.cust.bahnhof.se. [98.128.229.195])
 by smtp.gmail.com with ESMTPSA id b13sm162568ljf.107.2020.11.25.00.31.40
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 00:31:40 -0800 (PST)
To: lttng-dev@lists.lttng.org
Date: Wed, 25 Nov 2020 09:31:40 +0100
Message-Id: <20201125083140.25923-1-wallinux@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH lttng-tools] Extras: Perl 5.26 requires { to be
 escaped by \
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Anders Wallin via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Anders Wallin <wallinux@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Unescaped literal "{" characters in regular expression patterns are no
longer permissible

Signed-off-by: Anders Wallin <wallinux@gmail.com>
---
 extras/checkpatch.pl | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/extras/checkpatch.pl b/extras/checkpatch.pl
index 286c94de..14e16fae 100755
--- a/extras/checkpatch.pl
+++ b/extras/checkpatch.pl
@@ -2433,8 +2433,8 @@ sub process {
 
 # function brace can't be on same line, except for #defines of do while,
 # or if closed on same line
-		if (($line=~/$Type\s*$Ident\(.*\).*\s{/) and
-		    !($line=~/\#\s*define.*do\s{/) and !($line=~/}/)) {
+		if (($line=~/$Type\s*$Ident\(.*\).*\s\{/) and
+		    !($line=~/\#\s*define.*do\s\{/) and !($line=~/\}/)) {
 			ERROR("OPEN_BRACE",
 			      "open brace '{' following function declarations go on the next line\n" . $herecurr);
 		}
@@ -2709,8 +2709,8 @@ sub process {
 ## 		}
 
 #need space before brace following if, while, etc
-		if (($line =~ /\(.*\){/ && $line !~ /\($Type\){/) ||
-		    $line =~ /do{/) {
+		if (($line =~ /\(.*\)\{/ && $line !~ /\($Type\)\{/) ||
+		    $line =~ /do\{/) {
 			ERROR("SPACING",
 			      "space required before the open brace '{'\n" . $herecurr);
 		}
@@ -3005,7 +3005,7 @@ sub process {
 			    $dstat !~ /^for\s*$Constant$/ &&				# for (...)
 			    $dstat !~ /^for\s*$Constant\s+(?:$Ident|-?$Constant)$/ &&	# for (...) bar()
 			    $dstat !~ /^do\s*{/ &&					# do {...
-			    $dstat !~ /^\({/)						# ({...
+			    $dstat !~ /^\(\{/)						# ({...
 			{
 				$ctx =~ s/\n*$//;
 				my $herectx = $here . "\n";
-- 
2.29.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
