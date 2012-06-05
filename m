From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Expose kernel tracer to user-space
Date: Tue,  5 Jun 2012 11:20:49 +0200
Message-ID: <1338888051-20879-1-git-send-email-francis.giraldeau__2559.56342812187$1338888099$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lpp01m010-f48.google.com ([209.85.215.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1Sbpwr-0006sN-FL
	for lttng-dev@lists.lttng.org; Tue, 05 Jun 2012 05:21:09 -0400
Received: by lagz14 with SMTP id z14so4789282lag.35
	for <lttng-dev@lists.lttng.org>; Tue, 05 Jun 2012 02:21:02 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This series of patch follows the discussion about exposing kernel tracer to
user-space. Here are few highlights:

  * Creates one lttng_uevent kernel event by writing to /proc/lttng
  * The event is a variable size byte sequence, parsed by default as UTF-8 text
  * Uses already existing /proc/lttng file instead of creating another
  * Refactor the tp_memcpy macros to support sequence and copy_from_user
