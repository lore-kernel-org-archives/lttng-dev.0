From: Ted Cooper <theod@pdx.edu>
Subject: urcu: Where does HAS_INCOHERENT_CACHES come from?
Date: Fri, 16 Oct 2015 03:17:29 -0700
Message-ID: <CALcGr8weFzyHE3jdieQzWtXe9-G75c-JrqtWonhr3iHWPR_mzw__17437.8245989375$1444990723$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0242807086=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <theod@pdx.edu>) id 1Zn24t-0001fU-8t
 for lttng-dev@lists.lttng.org; Fri, 16 Oct 2015 06:17:36 -0400
Received: by wicgb1 with SMTP id gb1so2984526wic.1
 for <lttng-dev@lists.lttng.org>; Fri, 16 Oct 2015 03:17:29 -0700 (PDT)
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

--===============0242807086==
Content-Type: multipart/alternative; boundary=047d7b86df7a5eb9360522361ad7

--047d7b86df7a5eb9360522361ad7
Content-Type: text/plain; charset=UTF-8

This seems like a macro that is unique to the userspace-rcu codebase, but I
can't anything that mentions it besides some #ifndefs.

Thanks,
Ted

--047d7b86df7a5eb9360522361ad7
Content-Type: text/html; charset=UTF-8

<div dir="ltr">This seems like a macro that is unique to the userspace-rcu codebase, but I can&#39;t anything that mentions it besides some #ifndefs.<div><br></div><div>Thanks,</div><div>Ted</div></div>

--047d7b86df7a5eb9360522361ad7--


--===============0242807086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0242807086==--
