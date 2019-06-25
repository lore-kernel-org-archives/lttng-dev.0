From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: [RELEASE] Babeltrace 1.5.7
Date: Tue, 25 Jun 2019 14:31:02 -0400
Message-ID: <20190625183102.GA5109__49712.6771764428$1561487485$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by lists.lttng.org (Postfix) with ESMTPS id 45YF963Xfjz17qq
 for <lttng-dev@lists.lttng.org>; Tue, 25 Jun 2019 14:31:06 -0400 (EDT)
Received: by mail-qt1-f174.google.com with SMTP id d23so4161578qto.2
 for <lttng-dev@lists.lttng.org>; Tue, 25 Jun 2019 11:31:06 -0700 (PDT)
Received: from gmail.com (192-222-181-218.qc.cable.ebox.net. [192.222.181.218])
 by smtp.gmail.com with ESMTPSA id f25sm9048227qta.81.2019.06.25.11.31.04
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 11:31:04 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi all,

Today we are releasing the seventh bug-fix release of Babeltrace
1.5.7. This release addresses a number of issues listed below.

2019-06-25 lttng-tools 1.5.7 (Global Beatles Day)
	* Cleanup: bitfields: streamline use of underscores
	* Fix: bitfield: shift undefined/implementation defined behaviors
	* Fix: array and sequence field's 'elems' members can be left NULL
	* Fix: invalid alignment of enumeration fields

Project website: http://diamon.org/babeltrace/
Download link: http://www.efficios.com/files/babeltrace/babeltrace-1.5.7.tar.bz2
CTF specification: http://diamon.org/ctf/
