Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78A8C6FA8F
	for <lttng-dev@archiver.kernel.org>; Wed, 30 Aug 2023 14:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1693406598;
	bh=0nQ5RGFXPfXXQpkhvJ8jftmq3L0ISVDSFXPPI2B2Nw4=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=U2lPdoU+KiLEp1gE5ErEw1HyfMBc8QG+Tv2mb6Nq0mFtoX+hX4oIym9VSRFQuLggu
	 iC7ZGI5csLzPP9P6RGU+tPTXrVZ4uHIlDm/1i7bVIPSYYGPGnZxbGCaeSFYAseje9U
	 WOPA2Bp0YSrvuhopNJXFP/texthIGEkF1kM5SdjNiPgYnDo8gtL8Lj+y1/+sK3kX6O
	 WMY+60uKLRKTOK36xbaPbbLtRmKO1YE43h3LGzcRCfLipMaVbWoeus20+6nbSuICUm
	 weVZ98MismQ2oMI+2OnIEnIdJNOAbWVCdNTAI6j4nmfd+/+sRGrWeFJDZr0/iqC8jd
	 1XQv0QXgsXqSw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RbRqT6q5mz2TLQ;
	Wed, 30 Aug 2023 10:43:17 -0400 (EDT)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by lists.lttng.org (Postfix) with ESMTPS id 4Rb6PC5z37z2SyF
 for <lttng-dev@lists.lttng.org>; Tue, 29 Aug 2023 21:37:51 -0400 (EDT)
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50078eba7afso8123685e87.0
 for <lttng-dev@lists.lttng.org>; Tue, 29 Aug 2023 18:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693359470; x=1693964270;
 h=subject:from:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vgjxar7y6HOOV5uvN1/QMdr1jxXJ5cHphkIaGSIUdNE=;
 b=MvLEy1AdFq/4QHNPBo+cXRaW8+qVy2UADkYDDNYBUTPoV/Qc4MFIuFw/j/0su/u77v
 4C7afuB2GgMJrjVXg2W3sp1ajRxk9lSMOr5YWG6Xn0aNAeVa5/6u4WcLVLYHJt3M1rHA
 nAw8c7GT95NSNavOnWtoyu0H6lCHHSoniz5BxI5tlLjSOYnqn/YMj2Vz/iqwZwIQrJzZ
 /iGChHFoJvakykPYcUpTOCoqNLa46EHDeaI55IFoTD+cLS/cW9u6V5SZEZrJ+/ecL5q/
 JtfTohNOawKAbtfI1E7uVoX7xfxF3lhj7Wxn8a6aQkdIky1tcRSvd7m84wKzCxkW5LZn
 PPnA==
X-Gm-Message-State: AOJu0YySp7Koo/zK9JsrrjzeY7tWAnjQ6s8uRd7UJ9rg5MIxd5ASv6G8
 2DZxcP7k/iPPsph9th50nMoyWQEIN8c=
X-Google-Smtp-Source: AGHT+IHJs0IB6ChNyUqiqP/rmqp9rrgVgbg8imGGxr2mU+22Qs9DVrs+F1WR0Vysm0ioA1FwYOltaQ==
X-Received: by 2002:a05:651c:104a:b0:2bb:bfa5:b72c with SMTP id
 x10-20020a05651c104a00b002bbbfa5b72cmr682469ljm.15.1693359468888; 
 Tue, 29 Aug 2023 18:37:48 -0700 (PDT)
Received: from [192.168.1.5] ([176.214.202.210])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a2e8084000000b002b9e0aeff68sm2373103ljg.95.2023.08.29.18.37.47
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 18:37:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------YRxpbhoRI0ad0ue0ttEFfsYv"
Message-ID: <43c25c75-3e34-9e24-e466-f6bd1d7a1c4e@gmail.com>
Date: Wed, 30 Aug 2023 09:37:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Wed, 30 Aug 2023 10:43:15 -0400
Subject: [lttng-dev] userspace-rcu-0.14.0 - make check bug
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
From: Alexei Sholomitskiy via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Alexei Sholomitskiy <asholomitskiy84@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

This is a multi-part message in MIME format.
--------------YRxpbhoRI0ad0ue0ttEFfsYv
Content-Type: multipart/alternative;
 boundary="------------KF0zW7IotLyc1jf1act854Dv"

--------------KF0zW7IotLyc1jf1act854Dv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi! I have got but in make check

I have attached my Linux system descripption in mysystem.txt

tar xjvf userspace-rcu-0.14.0.tar.bz2

./configure --prefix=/libs/librcu-0.14.0 --enable-rcu-debug 
--enable-cds-lfht-iter-debug --disable-static

make

alexei@Aspire:~/build/liburcu-0.14.0$ make check
Making check in include
make[1]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/include'
make[1]: Leaving directory '/mnt/Git/apt-build/build/liburcu-0.14.0/include'
Making check in src
make[1]: Entering directory '/mnt/Git/apt-build/build/liburcu-0.14.0/src'
make[1]: Nothing to be done for 'check'.
make[1]: Leaving directory '/mnt/Git/apt-build/build/liburcu-0.14.0/src'
Making check in doc
make[1]: Entering directory '/mnt/Git/apt-build/build/liburcu-0.14.0/doc'
Making check in examples
make[2]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples'
make[3]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples'
make[4]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'
make[4]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'
make[4]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'
make[4]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'
make[4]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'
make[4]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'
make[4]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfcqueue'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfcqueue'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfcqueue'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfcqueue'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfcqueue'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfcqueue'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfcqueue'
make[4]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfcqueue'
make[4]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfqueue'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfqueue'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfqueue'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfqueue'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfqueue'
make[4]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfqueue'
make[4]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfstack'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfstack'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfstack'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfstack'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfstack'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfstack'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfstack'
make[4]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfstack'
make[4]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/lfstack'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/lfstack'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/lfstack'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/lfstack'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/lfstack'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/lfstack'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/lfstack'
make[4]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/lfstack'
make[4]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'
make[5]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'
make[5]: Nothing to be done for 'all'.
make[5]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'
make[4]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'
make[3]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples'
make[2]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples'
make[2]: Entering directory '/mnt/Git/apt-build/build/liburcu-0.14.0/doc'
make[2]: Nothing to be done for 'check-am'.
make[2]: Leaving directory '/mnt/Git/apt-build/build/liburcu-0.14.0/doc'
make[1]: Leaving directory '/mnt/Git/apt-build/build/liburcu-0.14.0/doc'
Making check in tests
make[1]: Entering directory '/mnt/Git/apt-build/build/liburcu-0.14.0/tests'
Making check in utils
make[2]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/tests/utils'
make  tap-driver.sh tap.sh utils.sh
make[3]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/tests/utils'
make[3]: Nothing to be done for 'tap-driver.sh'.
make[3]: Nothing to be done for 'tap.sh'.
make[3]: Nothing to be done for 'utils.sh'.
make[3]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/tests/utils'
make[2]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/tests/utils'
Making check in common
make[2]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/tests/common'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/tests/common'
Making check in unit
make[2]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/tests/unit'
make  check-TESTS
make[3]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/tests/unit'
make[4]: Entering directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/tests/unit'
PASS: test_arch 1 - caa_get_cycles works
PASS: test_arch_cxx 1 - caa_get_cycles works
PASS: test_get_cpu_mask_from_sysfs 1 - test_get_cpu_mask_from_sysfs - 
without '\n' expected: '', result: ''
PASS: test_get_cpu_mask_from_sysfs 2 - test_get_cpu_mask_from_sysfs - 
with '\n' expected: '', result: ''
PASS: test_get_cpu_mask_from_sysfs 3 - test_get_cpu_mask_from_sysfs - 
without '\n' expected: '0', result: '0'
PASS: test_get_cpu_mask_from_sysfs 4 - test_get_cpu_mask_from_sysfs - 
with '\n' expected: '0', result: '0'
PASS: test_get_cpu_mask_from_sysfs 5 - test_get_cpu_mask_from_sysfs - 
without '\n' expected: '0-3', result: '0-3'
PASS: test_get_cpu_mask_from_sysfs 6 - test_get_cpu_mask_from_sysfs - 
with '\n' expected: '0-3', result: '0-3'
PASS: test_get_cpu_mask_from_sysfs 7 - test_get_cpu_mask_from_sysfs - 
without '\n' expected: '0,3-7,9', result: '0,3-7,9'
PASS: test_get_cpu_mask_from_sysfs 8 - test_get_cpu_mask_from_sysfs - 
with '\n' expected: '0,3-7,9', result: '0,3-7,9'
PASS: test_get_cpu_mask_from_sysfs_cxx 1 - 
test_get_cpu_mask_from_sysfs_cxx - without '\n' expected: '', result: ''
PASS: test_get_cpu_mask_from_sysfs_cxx 2 - 
test_get_cpu_mask_from_sysfs_cxx - with '\n' expected: '', result: ''
PASS: test_get_cpu_mask_from_sysfs_cxx 3 - 
test_get_cpu_mask_from_sysfs_cxx - without '\n' expected: '0', result: '0'
PASS: test_get_cpu_mask_from_sysfs_cxx 4 - 
test_get_cpu_mask_from_sysfs_cxx - with '\n' expected: '0', result: '0'
PASS: test_get_cpu_mask_from_sysfs_cxx 5 - 
test_get_cpu_mask_from_sysfs_cxx - without '\n' expected: '0-3', result: 
'0-3'
PASS: test_get_cpu_mask_from_sysfs_cxx 6 - 
test_get_cpu_mask_from_sysfs_cxx - with '\n' expected: '0-3', result: '0-3'
PASS: test_get_cpu_mask_from_sysfs_cxx 7 - 
test_get_cpu_mask_from_sysfs_cxx - without '\n' expected: '0,3-7,9', 
result: '0,3-7,9'
PASS: test_get_cpu_mask_from_sysfs_cxx 8 - 
test_get_cpu_mask_from_sysfs_cxx - with '\n' expected: '0,3-7,9', 
result: '0,3-7,9'
# test_get_max_cpuid_from_mask: Testing smp helpers
PASS: test_get_max_cpuid_from_mask 1 - get_max_cpuid_from_mask '', 
expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask 2 - get_max_cpuid_from_mask 'abc', 
expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask 3 - get_max_cpuid_from_mask ',,,', 
expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask 4 - get_max_cpuid_from_mask '--', 
expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask 5 - get_max_cpuid_from_mask ',', 
expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask 6 - get_max_cpuid_from_mask '-', 
expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask 7 - get_max_cpuid_from_mask 
'2147483647', expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask 8 - get_max_cpuid_from_mask 
'18446744073709551615', expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask 9 - get_max_cpuid_from_mask 
'0-2147483647', expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask 10 - get_max_cpuid_from_mask 
'0-18446744073709551615', expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask 11 - get_max_cpuid_from_mask '0', 
expected: '0', result: '0'
PASS: test_get_max_cpuid_from_mask 12 - get_max_cpuid_from_mask '1', 
expected: '1', result: '1'
PASS: test_get_max_cpuid_from_mask 13 - get_max_cpuid_from_mask '0-1', 
expected: '1', result: '1'
PASS: test_get_max_cpuid_from_mask 14 - get_max_cpuid_from_mask '1-3', 
expected: '3', result: '3'
PASS: test_get_max_cpuid_from_mask 15 - get_max_cpuid_from_mask '0,2', 
expected: '2', result: '2'
PASS: test_get_max_cpuid_from_mask 16 - get_max_cpuid_from_mask '1,2', 
expected: '2', result: '2'
PASS: test_get_max_cpuid_from_mask 17 - get_max_cpuid_from_mask 
'0,4-6,127', expected: '127', result: '127'
PASS: test_get_max_cpuid_from_mask 18 - get_max_cpuid_from_mask 
'0-4095', expected: '4095', result: '4095'
PASS: test_get_max_cpuid_from_mask 19 - get_max_cpuid_from_mask '
PASS: test_get_max_cpuid_from_mask 20 - get_max_cpuid_from_mask 'abc
PASS: test_get_max_cpuid_from_mask 21 - get_max_cpuid_from_mask ',,,
PASS: test_get_max_cpuid_from_mask 22 - get_max_cpuid_from_mask '--
PASS: test_get_max_cpuid_from_mask 23 - get_max_cpuid_from_mask ',
PASS: test_get_max_cpuid_from_mask 24 - get_max_cpuid_from_mask '-
PASS: test_get_max_cpuid_from_mask 25 - get_max_cpuid_from_mask '2147483647
PASS: test_get_max_cpuid_from_mask 26 - get_max_cpuid_from_mask 
'18446744073709551615
PASS: test_get_max_cpuid_from_mask 27 - get_max_cpuid_from_mask 
'0-2147483647
PASS: test_get_max_cpuid_from_mask 28 - get_max_cpuid_from_mask 
'0-18446744073709551615
PASS: test_get_max_cpuid_from_mask 29 - get_max_cpuid_from_mask '0
PASS: test_get_max_cpuid_from_mask 30 - get_max_cpuid_from_mask '1
PASS: test_get_max_cpuid_from_mask 31 - get_max_cpuid_from_mask '0-1
PASS: test_get_max_cpuid_from_mask 32 - get_max_cpuid_from_mask '1-3
PASS: test_get_max_cpuid_from_mask 33 - get_max_cpuid_from_mask '0,2
PASS: test_get_max_cpuid_from_mask 34 - get_max_cpuid_from_mask '1,2
PASS: test_get_max_cpuid_from_mask 35 - get_max_cpuid_from_mask '0,4-6,127
PASS: test_get_max_cpuid_from_mask 36 - get_max_cpuid_from_mask '0-4095
# test_get_max_cpuid_from_mask_cxx: Testing smp helpers
PASS: test_get_max_cpuid_from_mask_cxx 1 - get_max_cpuid_from_mask '', 
expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask_cxx 2 - get_max_cpuid_from_mask 
'abc', expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask_cxx 3 - get_max_cpuid_from_mask 
',,,', expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask_cxx 4 - get_max_cpuid_from_mask '--', 
expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask_cxx 5 - get_max_cpuid_from_mask ',', 
expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask_cxx 6 - get_max_cpuid_from_mask '-', 
expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask_cxx 7 - get_max_cpuid_from_mask 
'2147483647', expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask_cxx 8 - get_max_cpuid_from_mask 
'18446744073709551615', expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask_cxx 9 - get_max_cpuid_from_mask 
'0-2147483647', expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask_cxx 10 - get_max_cpuid_from_mask 
'0-18446744073709551615', expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_mask_cxx 11 - get_max_cpuid_from_mask '0', 
expected: '0', result: '0'
PASS: test_get_max_cpuid_from_mask_cxx 12 - get_max_cpuid_from_mask '1', 
expected: '1', result: '1'
PASS: test_get_max_cpuid_from_mask_cxx 13 - get_max_cpuid_from_mask 
'0-1', expected: '1', result: '1'
PASS: test_get_max_cpuid_from_mask_cxx 14 - get_max_cpuid_from_mask 
'1-3', expected: '3', result: '3'
PASS: test_get_max_cpuid_from_mask_cxx 15 - get_max_cpuid_from_mask 
'0,2', expected: '2', result: '2'
PASS: test_get_max_cpuid_from_mask_cxx 16 - get_max_cpuid_from_mask 
'1,2', expected: '2', result: '2'
PASS: test_get_max_cpuid_from_mask_cxx 17 - get_max_cpuid_from_mask 
'0,4-6,127', expected: '127', result: '127'
PASS: test_get_max_cpuid_from_mask_cxx 18 - get_max_cpuid_from_mask 
'0-4095', expected: '4095', result: '4095'
PASS: test_get_max_cpuid_from_mask_cxx 19 - get_max_cpuid_from_mask '
PASS: test_get_max_cpuid_from_mask_cxx 20 - get_max_cpuid_from_mask 'abc
PASS: test_get_max_cpuid_from_mask_cxx 21 - get_max_cpuid_from_mask ',,,
PASS: test_get_max_cpuid_from_mask_cxx 22 - get_max_cpuid_from_mask '--
PASS: test_get_max_cpuid_from_mask_cxx 23 - get_max_cpuid_from_mask ',
PASS: test_get_max_cpuid_from_mask_cxx 24 - get_max_cpuid_from_mask '-
PASS: test_get_max_cpuid_from_mask_cxx 25 - get_max_cpuid_from_mask 
'2147483647
PASS: test_get_max_cpuid_from_mask_cxx 26 - get_max_cpuid_from_mask 
'18446744073709551615
PASS: test_get_max_cpuid_from_mask_cxx 27 - get_max_cpuid_from_mask 
'0-2147483647
PASS: test_get_max_cpuid_from_mask_cxx 28 - get_max_cpuid_from_mask 
'0-18446744073709551615
PASS: test_get_max_cpuid_from_mask_cxx 29 - get_max_cpuid_from_mask '0
PASS: test_get_max_cpuid_from_mask_cxx 30 - get_max_cpuid_from_mask '1
PASS: test_get_max_cpuid_from_mask_cxx 31 - get_max_cpuid_from_mask '0-1
PASS: test_get_max_cpuid_from_mask_cxx 32 - get_max_cpuid_from_mask '1-3
PASS: test_get_max_cpuid_from_mask_cxx 33 - get_max_cpuid_from_mask '0,2
PASS: test_get_max_cpuid_from_mask_cxx 34 - get_max_cpuid_from_mask '1,2
PASS: test_get_max_cpuid_from_mask_cxx 35 - get_max_cpuid_from_mask 
'0,4-6,127
PASS: test_get_max_cpuid_from_mask_cxx 36 - get_max_cpuid_from_mask '0-4095
# test_get_max_cpuid_from_sysfs: get_max_cpuid_from_sysfs
PASS: test_get_max_cpuid_from_sysfs 1 - get_max_cpuid_from_sysfs - cpu 
set: 'cpu0', expected: '0', result: '0'
PASS: test_get_max_cpuid_from_sysfs 2 - get_max_cpuid_from_sysfs - cpu 
set: 'cpu0 cpu1', expected: '1', result: '1'
PASS: test_get_max_cpuid_from_sysfs 3 - get_max_cpuid_from_sysfs - cpu 
set: 'cpu1 cpu0', expected: '1', result: '1'
PASS: test_get_max_cpuid_from_sysfs 4 - get_max_cpuid_from_sysfs - cpu 
set: 'cpu3', expected: '3', result: '3'
PASS: test_get_max_cpuid_from_sysfs 5 - get_max_cpuid_from_sysfs - cpu 
set: 'cpu99', expected: '99', result: '99'
PASS: test_get_max_cpuid_from_sysfs 6 - get_max_cpuid_from_sysfs - cpu 
set: 'cpu0 cpu3', expected: '3', result: '3'
PASS: test_get_max_cpuid_from_sysfs 7 - get_max_cpuid_from_sysfs - cpu 
set: 'cpufreq cpuidle cpu0 cpu1 cpu2 cpu3', expected: '3', result: '3'
PASS: test_get_max_cpuid_from_sysfs 8 - get_max_cpuid_from_sysfs - cpu 
set: 'cpu cpu0', expected: '0', result: '0'
PASS: test_get_max_cpuid_from_sysfs 9 - get_max_cpuid_from_sysfs - cpu 
set: 'cpu cpu5', expected: '5', result: '5'
PASS: test_get_max_cpuid_from_sysfs 10 - get_max_cpuid_from_sysfs - cpu 
set: 'toto', expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_sysfs 11 - get_max_cpuid_from_sysfs - cpu 
set: 'cpu', expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_sysfs 12 - get_max_cpuid_from_sysfs - cpu 
set: 'cpua cpud', expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_sysfs 13 - get_max_cpuid_from_sysfs - cpu 
set: 'cpufreq cpuidle', expected: '-1', result: '-1'
# test_get_max_cpuid_from_sysfs_cxx: get_max_cpuid_from_sysfs_cxx
PASS: test_get_max_cpuid_from_sysfs_cxx 1 - get_max_cpuid_from_sysfs_cxx 
- cpu set: 'cpu0', expected: '0', result: '0'
PASS: test_get_max_cpuid_from_sysfs_cxx 2 - get_max_cpuid_from_sysfs_cxx 
- cpu set: 'cpu0 cpu1', expected: '1', result: '1'
PASS: test_get_max_cpuid_from_sysfs_cxx 3 - get_max_cpuid_from_sysfs_cxx 
- cpu set: 'cpu1 cpu0', expected: '1', result: '1'
PASS: test_get_max_cpuid_from_sysfs_cxx 4 - get_max_cpuid_from_sysfs_cxx 
- cpu set: 'cpu3', expected: '3', result: '3'
PASS: test_get_max_cpuid_from_sysfs_cxx 5 - get_max_cpuid_from_sysfs_cxx 
- cpu set: 'cpu99', expected: '99', result: '99'
PASS: test_get_max_cpuid_from_sysfs_cxx 6 - get_max_cpuid_from_sysfs_cxx 
- cpu set: 'cpu0 cpu3', expected: '3', result: '3'
PASS: test_get_max_cpuid_from_sysfs_cxx 7 - get_max_cpuid_from_sysfs_cxx 
- cpu set: 'cpufreq cpuidle cpu0 cpu1 cpu2 cpu3', expected: '3', result: '3'
PASS: test_get_max_cpuid_from_sysfs_cxx 8 - get_max_cpuid_from_sysfs_cxx 
- cpu set: 'cpu cpu0', expected: '0', result: '0'
PASS: test_get_max_cpuid_from_sysfs_cxx 9 - get_max_cpuid_from_sysfs_cxx 
- cpu set: 'cpu cpu5', expected: '5', result: '5'
PASS: test_get_max_cpuid_from_sysfs_cxx 10 - 
get_max_cpuid_from_sysfs_cxx - cpu set: 'toto', expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_sysfs_cxx 11 - 
get_max_cpuid_from_sysfs_cxx - cpu set: 'cpu', expected: '-1', result: '-1'
PASS: test_get_max_cpuid_from_sysfs_cxx 12 - 
get_max_cpuid_from_sysfs_cxx - cpu set: 'cpua cpud', expected: '-1', 
result: '-1'
PASS: test_get_max_cpuid_from_sysfs_cxx 13 - 
get_max_cpuid_from_sysfs_cxx - cpu set: 'cpufreq cpuidle', expected: 
'-1', result: '-1'
PASS: test_get_possible_cpus_array_len 1 - get_possible_cpus_array_len 
(4 > 0)
PASS: test_get_possible_cpus_array_len 2 - 
get_num_possible_cpus_fallback (4 > 0)
PASS: test_get_possible_cpus_array_len_cxx 1 - 
get_possible_cpus_array_len (4 > 0)
PASS: test_get_possible_cpus_array_len_cxx 2 - 
get_num_possible_cpus_fallback (4 > 0)
# test_uatomic: Test atomic ops on byte
PASS: test_uatomic 1 - uatomic_read(&vals.c) == 10
PASS: test_uatomic 2 - uatomic_read(&vals.c) == (__typeof__(*(&vals.c)))-1UL
PASS: test_uatomic 3 - uatomic_read(&vals.c) == 22
PASS: test_uatomic 4 - v == (__typeof__(*(&vals.c)))-1UL
PASS: test_uatomic 5 - uatomic_read(&vals.c) == 22
PASS: test_uatomic 6 - v == 22
PASS: test_uatomic 7 - uatomic_read(&vals.c) == 55
PASS: test_uatomic 8 - v == 22
PASS: test_uatomic 9 - uatomic_read(&vals.c) == 23
PASS: test_uatomic 10 - uatomic_read(&vals.c) == 22
PASS: test_uatomic 11 - v == 96
PASS: test_uatomic 12 - uatomic_read(&vals.c) == 96
PASS: test_uatomic 13 - uatomic_read(&vals.c) == 122
PASS: test_uatomic 14 - v == 121
PASS: test_uatomic 15 - uatomic_read(&vals.c) == 119
PASS: test_uatomic 16 - uatomic_read(&vals.c) == 121
PASS: test_uatomic 17 - uatomic_read(&vals.c) == 1
# test_uatomic: Test atomic ops on short
PASS: test_uatomic 18 - uatomic_read(&vals.s) == 10
PASS: test_uatomic 19 - uatomic_read(&vals.s) == 
(__typeof__(*(&vals.s)))-1UL
PASS: test_uatomic 20 - uatomic_read(&vals.s) == 22
PASS: test_uatomic 21 - v == (__typeof__(*(&vals.s)))-1UL
PASS: test_uatomic 22 - uatomic_read(&vals.s) == 22
PASS: test_uatomic 23 - v == 22
PASS: test_uatomic 24 - uatomic_read(&vals.s) == 55
PASS: test_uatomic 25 - v == 22
PASS: test_uatomic 26 - uatomic_read(&vals.s) == 23
PASS: test_uatomic 27 - uatomic_read(&vals.s) == 22
PASS: test_uatomic 28 - v == 96
PASS: test_uatomic 29 - uatomic_read(&vals.s) == 96
PASS: test_uatomic 30 - uatomic_read(&vals.s) == 122
PASS: test_uatomic 31 - v == 121
PASS: test_uatomic 32 - uatomic_read(&vals.s) == 119
PASS: test_uatomic 33 - uatomic_read(&vals.s) == 121
PASS: test_uatomic 34 - uatomic_read(&vals.s) == 1
# test_uatomic: Test atomic ops on int
PASS: test_uatomic 35 - uatomic_read(&vals.i) == 10
PASS: test_uatomic 36 - uatomic_read(&vals.i) == 
(__typeof__(*(&vals.i)))-1UL
PASS: test_uatomic 37 - uatomic_read(&vals.i) == 22
PASS: test_uatomic 38 - v == (__typeof__(*(&vals.i)))-1UL
PASS: test_uatomic 39 - uatomic_read(&vals.i) == 22
PASS: test_uatomic 40 - v == 22
PASS: test_uatomic 41 - uatomic_read(&vals.i) == 55
PASS: test_uatomic 42 - v == 22
PASS: test_uatomic 43 - uatomic_read(&vals.i) == 23
PASS: test_uatomic 44 - uatomic_read(&vals.i) == 22
PASS: test_uatomic 45 - v == 96
PASS: test_uatomic 46 - uatomic_read(&vals.i) == 96
PASS: test_uatomic 47 - uatomic_read(&vals.i) == 122
PASS: test_uatomic 48 - v == 121
PASS: test_uatomic 49 - uatomic_read(&vals.i) == 119
PASS: test_uatomic 50 - uatomic_read(&vals.i) == 121
PASS: test_uatomic 51 - uatomic_read(&vals.i) == 1
# test_uatomic: Test atomic ops on long
PASS: test_uatomic 52 - uatomic_read(&vals.l) == 10
PASS: test_uatomic 53 - uatomic_read(&vals.l) == 
(__typeof__(*(&vals.l)))-1UL
PASS: test_uatomic 54 - uatomic_read(&vals.l) == 22
PASS: test_uatomic 55 - v == (__typeof__(*(&vals.l)))-1UL
PASS: test_uatomic 56 - uatomic_read(&vals.l) == 22
PASS: test_uatomic 57 - v == 22
PASS: test_uatomic 58 - uatomic_read(&vals.l) == 55
PASS: test_uatomic 59 - v == 22
PASS: test_uatomic 60 - uatomic_read(&vals.l) == 23
PASS: test_uatomic 61 - uatomic_read(&vals.l) == 22
PASS: test_uatomic 62 - v == 96
PASS: test_uatomic 63 - uatomic_read(&vals.l) == 96
PASS: test_uatomic 64 - uatomic_read(&vals.l) == 122
PASS: test_uatomic 65 - v == 121
PASS: test_uatomic 66 - uatomic_read(&vals.l) == 119
PASS: test_uatomic 67 - uatomic_read(&vals.l) == 121
PASS: test_uatomic 68 - uatomic_read(&vals.l) == 1
# test_uatomic_cxx: Test atomic ops on byte
PASS: test_uatomic_cxx 1 - uatomic_read(&vals.c) == 10
PASS: test_uatomic_cxx 2 - uatomic_read(&vals.c) == 
(__typeof__(*(&vals.c)))-1UL
PASS: test_uatomic_cxx 3 - uatomic_read(&vals.c) == 22
PASS: test_uatomic_cxx 4 - v == (__typeof__(*(&vals.c)))-1UL
PASS: test_uatomic_cxx 5 - uatomic_read(&vals.c) == 22
PASS: test_uatomic_cxx 6 - v == 22
PASS: test_uatomic_cxx 7 - uatomic_read(&vals.c) == 55
PASS: test_uatomic_cxx 8 - v == 22
PASS: test_uatomic_cxx 9 - uatomic_read(&vals.c) == 23
PASS: test_uatomic_cxx 10 - uatomic_read(&vals.c) == 22
PASS: test_uatomic_cxx 11 - v == 96
PASS: test_uatomic_cxx 12 - uatomic_read(&vals.c) == 96
PASS: test_uatomic_cxx 13 - uatomic_read(&vals.c) == 122
PASS: test_uatomic_cxx 14 - v == 121
PASS: test_uatomic_cxx 15 - uatomic_read(&vals.c) == 119
PASS: test_uatomic_cxx 16 - uatomic_read(&vals.c) == 121
PASS: test_uatomic_cxx 17 - uatomic_read(&vals.c) == 1
# test_uatomic_cxx: Test atomic ops on short
PASS: test_uatomic_cxx 18 - uatomic_read(&vals.s) == 10
PASS: test_uatomic_cxx 19 - uatomic_read(&vals.s) == 
(__typeof__(*(&vals.s)))-1UL
PASS: test_uatomic_cxx 20 - uatomic_read(&vals.s) == 22
PASS: test_uatomic_cxx 21 - v == (__typeof__(*(&vals.s)))-1UL
PASS: test_uatomic_cxx 22 - uatomic_read(&vals.s) == 22
PASS: test_uatomic_cxx 23 - v == 22
PASS: test_uatomic_cxx 24 - uatomic_read(&vals.s) == 55
PASS: test_uatomic_cxx 25 - v == 22
PASS: test_uatomic_cxx 26 - uatomic_read(&vals.s) == 23
PASS: test_uatomic_cxx 27 - uatomic_read(&vals.s) == 22
PASS: test_uatomic_cxx 28 - v == 96
PASS: test_uatomic_cxx 29 - uatomic_read(&vals.s) == 96
PASS: test_uatomic_cxx 30 - uatomic_read(&vals.s) == 122
PASS: test_uatomic_cxx 31 - v == 121
PASS: test_uatomic_cxx 32 - uatomic_read(&vals.s) == 119
PASS: test_uatomic_cxx 33 - uatomic_read(&vals.s) == 121
PASS: test_uatomic_cxx 34 - uatomic_read(&vals.s) == 1
# test_uatomic_cxx: Test atomic ops on int
PASS: test_uatomic_cxx 35 - uatomic_read(&vals.i) == 10
PASS: test_uatomic_cxx 36 - uatomic_read(&vals.i) == 
(__typeof__(*(&vals.i)))-1UL
PASS: test_uatomic_cxx 37 - uatomic_read(&vals.i) == 22
PASS: test_uatomic_cxx 38 - v == (__typeof__(*(&vals.i)))-1UL
PASS: test_uatomic_cxx 39 - uatomic_read(&vals.i) == 22
PASS: test_uatomic_cxx 40 - v == 22
PASS: test_uatomic_cxx 41 - uatomic_read(&vals.i) == 55
PASS: test_uatomic_cxx 42 - v == 22
PASS: test_uatomic_cxx 43 - uatomic_read(&vals.i) == 23
PASS: test_uatomic_cxx 44 - uatomic_read(&vals.i) == 22
PASS: test_uatomic_cxx 45 - v == 96
PASS: test_uatomic_cxx 46 - uatomic_read(&vals.i) == 96
PASS: test_uatomic_cxx 47 - uatomic_read(&vals.i) == 122
PASS: test_uatomic_cxx 48 - v == 121
PASS: test_uatomic_cxx 49 - uatomic_read(&vals.i) == 119
PASS: test_uatomic_cxx 50 - uatomic_read(&vals.i) == 121
PASS: test_uatomic_cxx 51 - uatomic_read(&vals.i) == 1
# test_uatomic_cxx: Test atomic ops on long
PASS: test_uatomic_cxx 52 - uatomic_read(&vals.l) == 10
PASS: test_uatomic_cxx 53 - uatomic_read(&vals.l) == 
(__typeof__(*(&vals.l)))-1UL
PASS: test_uatomic_cxx 54 - uatomic_read(&vals.l) == 22
PASS: test_uatomic_cxx 55 - v == (__typeof__(*(&vals.l)))-1UL
PASS: test_uatomic_cxx 56 - uatomic_read(&vals.l) == 22
PASS: test_uatomic_cxx 57 - v == 22
PASS: test_uatomic_cxx 58 - uatomic_read(&vals.l) == 55
PASS: test_uatomic_cxx 59 - v == 22
PASS: test_uatomic_cxx 60 - uatomic_read(&vals.l) == 23
PASS: test_uatomic_cxx 61 - uatomic_read(&vals.l) == 22
PASS: test_uatomic_cxx 62 - v == 96
PASS: test_uatomic_cxx 63 - uatomic_read(&vals.l) == 96
PASS: test_uatomic_cxx 64 - uatomic_read(&vals.l) == 122
PASS: test_uatomic_cxx 65 - v == 121
PASS: test_uatomic_cxx 66 - uatomic_read(&vals.l) == 119
PASS: test_uatomic_cxx 67 - uatomic_read(&vals.l) == 121
PASS: test_uatomic_cxx 68 - uatomic_read(&vals.l) == 1
ERROR: test_urcu_multiflavor - too few tests run (expected 5, got 0)
ERROR: test_urcu_multiflavor - exited with status 134 (terminated by 
signal 6?)
ERROR: test_urcu_multiflavor_cxx - too few tests run (expected 5, got 0)
ERROR: test_urcu_multiflavor_cxx - exited with status 134 (terminated by 
signal 6?)
ERROR: test_urcu_multiflavor_dynlink - too few tests run (expected 5, got 0)
ERROR: test_urcu_multiflavor_dynlink - exited with status 134 
(terminated by signal 6?)
ERROR: test_urcu_multiflavor_dynlink_cxx - too few tests run (expected 
5, got 0)
ERROR: test_urcu_multiflavor_dynlink_cxx - exited with status 134 
(terminated by signal 6?)
PASS: test_urcu_multiflavor_single_unit 1 - !test_mf_mb()
PASS: test_urcu_multiflavor_single_unit 2 - !test_mf_bp()
ERROR: test_urcu_multiflavor_single_unit - too few tests run (expected 
5, got 2)
ERROR: test_urcu_multiflavor_single_unit - exited with status 134 
(terminated by signal 6?)
PASS: test_urcu_multiflavor_single_unit_cxx 1 - !test_mf_mb()
PASS: test_urcu_multiflavor_single_unit_cxx 2 - !test_mf_bp()
ERROR: test_urcu_multiflavor_single_unit_cxx - too few tests run 
(expected 5, got 2)
ERROR: test_urcu_multiflavor_single_unit_cxx - exited with status 134 
(terminated by signal 6?)
PASS: test_urcu_multiflavor_single_unit_dynlink 1 - !test_mf_mb()
PASS: test_urcu_multiflavor_single_unit_dynlink 2 - !test_mf_bp()
ERROR: test_urcu_multiflavor_single_unit_dynlink - too few tests run 
(expected 5, got 2)
ERROR: test_urcu_multiflavor_single_unit_dynlink - exited with status 
134 (terminated by signal 6?)
PASS: test_urcu_multiflavor_single_unit_dynlink_cxx 1 - !test_mf_mb()
PASS: test_urcu_multiflavor_single_unit_dynlink_cxx 2 - !test_mf_bp()
ERROR: test_urcu_multiflavor_single_unit_dynlink_cxx - too few tests run 
(expected 5, got 2)
ERROR: test_urcu_multiflavor_single_unit_dynlink_cxx - exited with 
status 134 (terminated by signal 6?)
PASS: test_build 1 - cds_lfs_empty
PASS: test_build 2 - cds_lfs_empty
PASS: test_build 3 - cds_wfcq_empty
PASS: test_build_cxx 1 - cds_lfs_empty
PASS: test_build_cxx 2 - cds_lfs_empty
PASS: test_build_cxx 3 - cds_wfcq_empty
PASS: test_build_dynlink 1 - cds_lfs_empty
PASS: test_build_dynlink 2 - cds_lfs_empty
PASS: test_build_dynlink 3 - cds_wfcq_empty
PASS: test_build_dynlink_cxx 1 - cds_lfs_empty
PASS: test_build_dynlink_cxx 2 - cds_lfs_empty
PASS: test_build_dynlink_cxx 3 - cds_wfcq_empty
============================================================================
Testsuite summary for userspace-rcu 0.14.0
============================================================================
# TOTAL: 292
# PASS:  276
# SKIP:  0
# XFAIL: 0
# FAIL:  0
# XPASS: 0
# ERROR: 16
============================================================================
See tests/unit/test-suite.log
Please report to mathieu dot desnoyers at efficios dot com
============================================================================
make[4]: *** [Makefile:1486: test-suite.log] Error 1
make[4]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/tests/unit'
make[3]: *** [Makefile:1594: check-TESTS] Error 2
make[3]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/tests/unit'
make[2]: *** [Makefile:1828: check-am] Error 2
make[2]: Leaving directory 
'/mnt/Git/apt-build/build/liburcu-0.14.0/tests/unit'
make[1]: *** [Makefile:382: check-recursive] Error 1
make[1]: Leaving directory '/mnt/Git/apt-build/build/liburcu-0.14.0/tests'
make: *** [Makefile:491: check-recursive] Error 1


--------------KF0zW7IotLyc1jf1act854Dv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body text="#ffffff" bgcolor="#000000">
    <p><font face="Ubuntu Mono">Hi! I have got but in make check<br>
      </font></p>
    <p><font face="Ubuntu Mono">I have attached my Linux system
        descripption in mysystem.txt<br>
      </font></p>
    <p><font face="Ubuntu Mono">tar xjvf userspace-rcu-0.14.0.tar.bz2</font></p>
    <p><font face="Ubuntu Mono">./configure --prefix=/libs/lib</font><font
        face="Ubuntu Mono"><font face="Ubuntu Mono">rcu-0.14.0</font>
        --enable-rcu-debug --enable-cds-lfht-iter-debug --disable-static</font></p>
    <p><font face="Ubuntu Mono">make</font></p>
    <p><font face="Ubuntu Mono"><a class="moz-txt-link-abbreviated" href="mailto:alexei@Aspire:~/build/liburcu-0.14.0$">alexei@Aspire:~/build/liburcu-0.14.0$</a>
        make check<br>
        Making check in include<br>
        make[1]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/include'<br>
        make[1]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/include'<br>
        Making check in src<br>
        make[1]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/src'<br>
        make[1]: Nothing to be done for 'check'.<br>
        make[1]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/src'<br>
        Making check in doc<br>
        make[1]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc'<br>
        Making check in examples<br>
        make[2]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples'<br>
        make[3]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples'<br>
        make[4]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'<br>
        make[4]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/hlist'<br>
        make[4]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'<br>
        make[4]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/list'<br>
        make[4]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'<br>
        make[4]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/urcu-flavors'<br>
        make[4]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfcqueue'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfcqueue'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfcqueue'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfcqueue'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfcqueue'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfcqueue'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfcqueue'<br>
        make[4]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfcqueue'<br>
        make[4]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfqueue'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfqueue'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfqueue'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfqueue'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfqueue'<br>
        make[4]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfqueue'<br>
        make[4]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfstack'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfstack'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfstack'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfstack'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfstack'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfstack'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfstack'<br>
        make[4]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/wfstack'<br>
        make[4]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/lfstack'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/lfstack'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/lfstack'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/lfstack'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/lfstack'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/lfstack'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/lfstack'<br>
        make[4]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/lfstack'<br>
        make[4]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'<br>
        make[5]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'<br>
        make[5]: Nothing to be done for 'all'.<br>
        make[5]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'<br>
        make[4]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples/rculfhash'<br>
        make[3]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples'<br>
        make[2]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc/examples'<br>
        make[2]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc'<br>
        make[2]: Nothing to be done for 'check-am'.<br>
        make[2]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc'<br>
        make[1]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/doc'<br>
        Making check in tests<br>
        make[1]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/tests'<br>
        Making check in utils<br>
        make[2]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/tests/utils'<br>
        make  tap-driver.sh tap.sh utils.sh<br>
        make[3]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/tests/utils'<br>
        make[3]: Nothing to be done for 'tap-driver.sh'.<br>
        make[3]: Nothing to be done for 'tap.sh'.<br>
        make[3]: Nothing to be done for 'utils.sh'.<br>
        make[3]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/tests/utils'<br>
        make[2]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/tests/utils'<br>
        Making check in common<br>
        make[2]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/tests/common'<br>
        make[2]: Nothing to be done for 'check'.<br>
        make[2]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/tests/common'<br>
        Making check in unit<br>
        make[2]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/tests/unit'<br>
        make  check-TESTS<br>
        make[3]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/tests/unit'<br>
        make[4]: Entering directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/tests/unit'<br>
        PASS: test_arch 1 - caa_get_cycles works<br>
        PASS: test_arch_cxx 1 - caa_get_cycles works<br>
        PASS: test_get_cpu_mask_from_sysfs 1 -
        test_get_cpu_mask_from_sysfs - without '\n' expected: '',
        result: ''<br>
        PASS: test_get_cpu_mask_from_sysfs 2 -
        test_get_cpu_mask_from_sysfs - with '\n' expected: '', result:
        ''<br>
        PASS: test_get_cpu_mask_from_sysfs 3 -
        test_get_cpu_mask_from_sysfs - without '\n' expected: '0',
        result: '0'<br>
        PASS: test_get_cpu_mask_from_sysfs 4 -
        test_get_cpu_mask_from_sysfs - with '\n' expected: '0', result:
        '0'<br>
        PASS: test_get_cpu_mask_from_sysfs 5 -
        test_get_cpu_mask_from_sysfs - without '\n' expected: '0-3',
        result: '0-3'<br>
        PASS: test_get_cpu_mask_from_sysfs 6 -
        test_get_cpu_mask_from_sysfs - with '\n' expected: '0-3',
        result: '0-3'<br>
        PASS: test_get_cpu_mask_from_sysfs 7 -
        test_get_cpu_mask_from_sysfs - without '\n' expected: '0,3-7,9',
        result: '0,3-7,9'<br>
        PASS: test_get_cpu_mask_from_sysfs 8 -
        test_get_cpu_mask_from_sysfs - with '\n' expected: '0,3-7,9',
        result: '0,3-7,9'<br>
        PASS: test_get_cpu_mask_from_sysfs_cxx 1 -
        test_get_cpu_mask_from_sysfs_cxx - without '\n' expected: '',
        result: ''<br>
        PASS: test_get_cpu_mask_from_sysfs_cxx 2 -
        test_get_cpu_mask_from_sysfs_cxx - with '\n' expected: '',
        result: ''<br>
        PASS: test_get_cpu_mask_from_sysfs_cxx 3 -
        test_get_cpu_mask_from_sysfs_cxx - without '\n' expected: '0',
        result: '0'<br>
        PASS: test_get_cpu_mask_from_sysfs_cxx 4 -
        test_get_cpu_mask_from_sysfs_cxx - with '\n' expected: '0',
        result: '0'<br>
        PASS: test_get_cpu_mask_from_sysfs_cxx 5 -
        test_get_cpu_mask_from_sysfs_cxx - without '\n' expected: '0-3',
        result: '0-3'<br>
        PASS: test_get_cpu_mask_from_sysfs_cxx 6 -
        test_get_cpu_mask_from_sysfs_cxx - with '\n' expected: '0-3',
        result: '0-3'<br>
        PASS: test_get_cpu_mask_from_sysfs_cxx 7 -
        test_get_cpu_mask_from_sysfs_cxx - without '\n' expected:
        '0,3-7,9', result: '0,3-7,9'<br>
        PASS: test_get_cpu_mask_from_sysfs_cxx 8 -
        test_get_cpu_mask_from_sysfs_cxx - with '\n' expected:
        '0,3-7,9', result: '0,3-7,9'<br>
        # test_get_max_cpuid_from_mask: Testing smp helpers<br>
        PASS: test_get_max_cpuid_from_mask 1 - get_max_cpuid_from_mask
        '', expected: '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask 2 - get_max_cpuid_from_mask
        'abc', expected: '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask 3 - get_max_cpuid_from_mask
        ',,,', expected: '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask 4 - get_max_cpuid_from_mask
        '--', expected: '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask 5 - get_max_cpuid_from_mask
        ',', expected: '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask 6 - get_max_cpuid_from_mask
        '-', expected: '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask 7 - get_max_cpuid_from_mask
        '2147483647', expected: '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask 8 - get_max_cpuid_from_mask
        '18446744073709551615', expected: '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask 9 - get_max_cpuid_from_mask
        '0-2147483647', expected: '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask 10 - get_max_cpuid_from_mask
        '0-18446744073709551615', expected: '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask 11 - get_max_cpuid_from_mask
        '0', expected: '0', result: '0'<br>
        PASS: test_get_max_cpuid_from_mask 12 - get_max_cpuid_from_mask
        '1', expected: '1', result: '1'<br>
        PASS: test_get_max_cpuid_from_mask 13 - get_max_cpuid_from_mask
        '0-1', expected: '1', result: '1'<br>
        PASS: test_get_max_cpuid_from_mask 14 - get_max_cpuid_from_mask
        '1-3', expected: '3', result: '3'<br>
        PASS: test_get_max_cpuid_from_mask 15 - get_max_cpuid_from_mask
        '0,2', expected: '2', result: '2'<br>
        PASS: test_get_max_cpuid_from_mask 16 - get_max_cpuid_from_mask
        '1,2', expected: '2', result: '2'<br>
        PASS: test_get_max_cpuid_from_mask 17 - get_max_cpuid_from_mask
        '0,4-6,127', expected: '127', result: '127'<br>
        PASS: test_get_max_cpuid_from_mask 18 - get_max_cpuid_from_mask
        '0-4095', expected: '4095', result: '4095'<br>
        PASS: test_get_max_cpuid_from_mask 19 - get_max_cpuid_from_mask
        '<br>
        PASS: test_get_max_cpuid_from_mask 20 - get_max_cpuid_from_mask
        'abc<br>
        PASS: test_get_max_cpuid_from_mask 21 - get_max_cpuid_from_mask
        ',,,<br>
        PASS: test_get_max_cpuid_from_mask 22 - get_max_cpuid_from_mask
        '--<br>
        PASS: test_get_max_cpuid_from_mask 23 - get_max_cpuid_from_mask
        ',<br>
        PASS: test_get_max_cpuid_from_mask 24 - get_max_cpuid_from_mask
        '-<br>
        PASS: test_get_max_cpuid_from_mask 25 - get_max_cpuid_from_mask
        '2147483647<br>
        PASS: test_get_max_cpuid_from_mask 26 - get_max_cpuid_from_mask
        '18446744073709551615<br>
        PASS: test_get_max_cpuid_from_mask 27 - get_max_cpuid_from_mask
        '0-2147483647<br>
        PASS: test_get_max_cpuid_from_mask 28 - get_max_cpuid_from_mask
        '0-18446744073709551615<br>
        PASS: test_get_max_cpuid_from_mask 29 - get_max_cpuid_from_mask
        '0<br>
        PASS: test_get_max_cpuid_from_mask 30 - get_max_cpuid_from_mask
        '1<br>
        PASS: test_get_max_cpuid_from_mask 31 - get_max_cpuid_from_mask
        '0-1<br>
        PASS: test_get_max_cpuid_from_mask 32 - get_max_cpuid_from_mask
        '1-3<br>
        PASS: test_get_max_cpuid_from_mask 33 - get_max_cpuid_from_mask
        '0,2<br>
        PASS: test_get_max_cpuid_from_mask 34 - get_max_cpuid_from_mask
        '1,2<br>
        PASS: test_get_max_cpuid_from_mask 35 - get_max_cpuid_from_mask
        '0,4-6,127<br>
        PASS: test_get_max_cpuid_from_mask 36 - get_max_cpuid_from_mask
        '0-4095<br>
        # test_get_max_cpuid_from_mask_cxx: Testing smp helpers<br>
        PASS: test_get_max_cpuid_from_mask_cxx 1 -
        get_max_cpuid_from_mask '', expected: '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 2 -
        get_max_cpuid_from_mask 'abc', expected: '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 3 -
        get_max_cpuid_from_mask ',,,', expected: '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 4 -
        get_max_cpuid_from_mask '--', expected: '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 5 -
        get_max_cpuid_from_mask ',', expected: '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 6 -
        get_max_cpuid_from_mask '-', expected: '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 7 -
        get_max_cpuid_from_mask '2147483647', expected: '-1', result:
        '-1'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 8 -
        get_max_cpuid_from_mask '18446744073709551615', expected: '-1',
        result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 9 -
        get_max_cpuid_from_mask '0-2147483647', expected: '-1', result:
        '-1'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 10 -
        get_max_cpuid_from_mask '0-18446744073709551615', expected:
        '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 11 -
        get_max_cpuid_from_mask '0', expected: '0', result: '0'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 12 -
        get_max_cpuid_from_mask '1', expected: '1', result: '1'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 13 -
        get_max_cpuid_from_mask '0-1', expected: '1', result: '1'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 14 -
        get_max_cpuid_from_mask '1-3', expected: '3', result: '3'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 15 -
        get_max_cpuid_from_mask '0,2', expected: '2', result: '2'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 16 -
        get_max_cpuid_from_mask '1,2', expected: '2', result: '2'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 17 -
        get_max_cpuid_from_mask '0,4-6,127', expected: '127', result:
        '127'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 18 -
        get_max_cpuid_from_mask '0-4095', expected: '4095', result:
        '4095'<br>
        PASS: test_get_max_cpuid_from_mask_cxx 19 -
        get_max_cpuid_from_mask '<br>
        PASS: test_get_max_cpuid_from_mask_cxx 20 -
        get_max_cpuid_from_mask 'abc<br>
        PASS: test_get_max_cpuid_from_mask_cxx 21 -
        get_max_cpuid_from_mask ',,,<br>
        PASS: test_get_max_cpuid_from_mask_cxx 22 -
        get_max_cpuid_from_mask '--<br>
        PASS: test_get_max_cpuid_from_mask_cxx 23 -
        get_max_cpuid_from_mask ',<br>
        PASS: test_get_max_cpuid_from_mask_cxx 24 -
        get_max_cpuid_from_mask '-<br>
        PASS: test_get_max_cpuid_from_mask_cxx 25 -
        get_max_cpuid_from_mask '2147483647<br>
        PASS: test_get_max_cpuid_from_mask_cxx 26 -
        get_max_cpuid_from_mask '18446744073709551615<br>
        PASS: test_get_max_cpuid_from_mask_cxx 27 -
        get_max_cpuid_from_mask '0-2147483647<br>
        PASS: test_get_max_cpuid_from_mask_cxx 28 -
        get_max_cpuid_from_mask '0-18446744073709551615<br>
        PASS: test_get_max_cpuid_from_mask_cxx 29 -
        get_max_cpuid_from_mask '0<br>
        PASS: test_get_max_cpuid_from_mask_cxx 30 -
        get_max_cpuid_from_mask '1<br>
        PASS: test_get_max_cpuid_from_mask_cxx 31 -
        get_max_cpuid_from_mask '0-1<br>
        PASS: test_get_max_cpuid_from_mask_cxx 32 -
        get_max_cpuid_from_mask '1-3<br>
        PASS: test_get_max_cpuid_from_mask_cxx 33 -
        get_max_cpuid_from_mask '0,2<br>
        PASS: test_get_max_cpuid_from_mask_cxx 34 -
        get_max_cpuid_from_mask '1,2<br>
        PASS: test_get_max_cpuid_from_mask_cxx 35 -
        get_max_cpuid_from_mask '0,4-6,127<br>
        PASS: test_get_max_cpuid_from_mask_cxx 36 -
        get_max_cpuid_from_mask '0-4095<br>
        # test_get_max_cpuid_from_sysfs: get_max_cpuid_from_sysfs<br>
        PASS: test_get_max_cpuid_from_sysfs 1 - get_max_cpuid_from_sysfs
        - cpu set: 'cpu0', expected: '0', result: '0'<br>
        PASS: test_get_max_cpuid_from_sysfs 2 - get_max_cpuid_from_sysfs
        - cpu set: 'cpu0 cpu1', expected: '1', result: '1'<br>
        PASS: test_get_max_cpuid_from_sysfs 3 - get_max_cpuid_from_sysfs
        - cpu set: 'cpu1 cpu0', expected: '1', result: '1'<br>
        PASS: test_get_max_cpuid_from_sysfs 4 - get_max_cpuid_from_sysfs
        - cpu set: 'cpu3', expected: '3', result: '3'<br>
        PASS: test_get_max_cpuid_from_sysfs 5 - get_max_cpuid_from_sysfs
        - cpu set: 'cpu99', expected: '99', result: '99'<br>
        PASS: test_get_max_cpuid_from_sysfs 6 - get_max_cpuid_from_sysfs
        - cpu set: 'cpu0 cpu3', expected: '3', result: '3'<br>
        PASS: test_get_max_cpuid_from_sysfs 7 - get_max_cpuid_from_sysfs
        - cpu set: 'cpufreq cpuidle cpu0 cpu1 cpu2 cpu3', expected: '3',
        result: '3'<br>
        PASS: test_get_max_cpuid_from_sysfs 8 - get_max_cpuid_from_sysfs
        - cpu set: 'cpu cpu0', expected: '0', result: '0'<br>
        PASS: test_get_max_cpuid_from_sysfs 9 - get_max_cpuid_from_sysfs
        - cpu set: 'cpu cpu5', expected: '5', result: '5'<br>
        PASS: test_get_max_cpuid_from_sysfs 10 -
        get_max_cpuid_from_sysfs - cpu set: 'toto', expected: '-1',
        result: '-1'<br>
        PASS: test_get_max_cpuid_from_sysfs 11 -
        get_max_cpuid_from_sysfs - cpu set: 'cpu', expected: '-1',
        result: '-1'<br>
        PASS: test_get_max_cpuid_from_sysfs 12 -
        get_max_cpuid_from_sysfs - cpu set: 'cpua cpud', expected: '-1',
        result: '-1'<br>
        PASS: test_get_max_cpuid_from_sysfs 13 -
        get_max_cpuid_from_sysfs - cpu set: 'cpufreq cpuidle', expected:
        '-1', result: '-1'<br>
        # test_get_max_cpuid_from_sysfs_cxx:
        get_max_cpuid_from_sysfs_cxx<br>
        PASS: test_get_max_cpuid_from_sysfs_cxx 1 -
        get_max_cpuid_from_sysfs_cxx - cpu set: 'cpu0', expected: '0',
        result: '0'<br>
        PASS: test_get_max_cpuid_from_sysfs_cxx 2 -
        get_max_cpuid_from_sysfs_cxx - cpu set: 'cpu0 cpu1', expected:
        '1', result: '1'<br>
        PASS: test_get_max_cpuid_from_sysfs_cxx 3 -
        get_max_cpuid_from_sysfs_cxx - cpu set: 'cpu1 cpu0', expected:
        '1', result: '1'<br>
        PASS: test_get_max_cpuid_from_sysfs_cxx 4 -
        get_max_cpuid_from_sysfs_cxx - cpu set: 'cpu3', expected: '3',
        result: '3'<br>
        PASS: test_get_max_cpuid_from_sysfs_cxx 5 -
        get_max_cpuid_from_sysfs_cxx - cpu set: 'cpu99', expected: '99',
        result: '99'<br>
        PASS: test_get_max_cpuid_from_sysfs_cxx 6 -
        get_max_cpuid_from_sysfs_cxx - cpu set: 'cpu0 cpu3', expected:
        '3', result: '3'<br>
        PASS: test_get_max_cpuid_from_sysfs_cxx 7 -
        get_max_cpuid_from_sysfs_cxx - cpu set: 'cpufreq cpuidle cpu0
        cpu1 cpu2 cpu3', expected: '3', result: '3'<br>
        PASS: test_get_max_cpuid_from_sysfs_cxx 8 -
        get_max_cpuid_from_sysfs_cxx - cpu set: 'cpu cpu0', expected:
        '0', result: '0'<br>
        PASS: test_get_max_cpuid_from_sysfs_cxx 9 -
        get_max_cpuid_from_sysfs_cxx - cpu set: 'cpu cpu5', expected:
        '5', result: '5'<br>
        PASS: test_get_max_cpuid_from_sysfs_cxx 10 -
        get_max_cpuid_from_sysfs_cxx - cpu set: 'toto', expected: '-1',
        result: '-1'<br>
        PASS: test_get_max_cpuid_from_sysfs_cxx 11 -
        get_max_cpuid_from_sysfs_cxx - cpu set: 'cpu', expected: '-1',
        result: '-1'<br>
        PASS: test_get_max_cpuid_from_sysfs_cxx 12 -
        get_max_cpuid_from_sysfs_cxx - cpu set: 'cpua cpud', expected:
        '-1', result: '-1'<br>
        PASS: test_get_max_cpuid_from_sysfs_cxx 13 -
        get_max_cpuid_from_sysfs_cxx - cpu set: 'cpufreq cpuidle',
        expected: '-1', result: '-1'<br>
        PASS: test_get_possible_cpus_array_len 1 -
        get_possible_cpus_array_len (4 &gt; 0)<br>
        PASS: test_get_possible_cpus_array_len 2 -
        get_num_possible_cpus_fallback (4 &gt; 0)<br>
        PASS: test_get_possible_cpus_array_len_cxx 1 -
        get_possible_cpus_array_len (4 &gt; 0)<br>
        PASS: test_get_possible_cpus_array_len_cxx 2 -
        get_num_possible_cpus_fallback (4 &gt; 0)<br>
        # test_uatomic: Test atomic ops on byte<br>
        PASS: test_uatomic 1 - uatomic_read(&amp;vals.c) == 10<br>
        PASS: test_uatomic 2 - uatomic_read(&amp;vals.c) ==
        (__typeof__(*(&amp;vals.c)))-1UL<br>
        PASS: test_uatomic 3 - uatomic_read(&amp;vals.c) == 22<br>
        PASS: test_uatomic 4 - v == (__typeof__(*(&amp;vals.c)))-1UL<br>
        PASS: test_uatomic 5 - uatomic_read(&amp;vals.c) == 22<br>
        PASS: test_uatomic 6 - v == 22<br>
        PASS: test_uatomic 7 - uatomic_read(&amp;vals.c) == 55<br>
        PASS: test_uatomic 8 - v == 22<br>
        PASS: test_uatomic 9 - uatomic_read(&amp;vals.c) == 23<br>
        PASS: test_uatomic 10 - uatomic_read(&amp;vals.c) == 22<br>
        PASS: test_uatomic 11 - v == 96<br>
        PASS: test_uatomic 12 - uatomic_read(&amp;vals.c) == 96<br>
        PASS: test_uatomic 13 - uatomic_read(&amp;vals.c) == 122<br>
        PASS: test_uatomic 14 - v == 121<br>
        PASS: test_uatomic 15 - uatomic_read(&amp;vals.c) == 119<br>
        PASS: test_uatomic 16 - uatomic_read(&amp;vals.c) == 121<br>
        PASS: test_uatomic 17 - uatomic_read(&amp;vals.c) == 1<br>
        # test_uatomic: Test atomic ops on short<br>
        PASS: test_uatomic 18 - uatomic_read(&amp;vals.s) == 10<br>
        PASS: test_uatomic 19 - uatomic_read(&amp;vals.s) ==
        (__typeof__(*(&amp;vals.s)))-1UL<br>
        PASS: test_uatomic 20 - uatomic_read(&amp;vals.s) == 22<br>
        PASS: test_uatomic 21 - v == (__typeof__(*(&amp;vals.s)))-1UL<br>
        PASS: test_uatomic 22 - uatomic_read(&amp;vals.s) == 22<br>
        PASS: test_uatomic 23 - v == 22<br>
        PASS: test_uatomic 24 - uatomic_read(&amp;vals.s) == 55<br>
        PASS: test_uatomic 25 - v == 22<br>
        PASS: test_uatomic 26 - uatomic_read(&amp;vals.s) == 23<br>
        PASS: test_uatomic 27 - uatomic_read(&amp;vals.s) == 22<br>
        PASS: test_uatomic 28 - v == 96<br>
        PASS: test_uatomic 29 - uatomic_read(&amp;vals.s) == 96<br>
        PASS: test_uatomic 30 - uatomic_read(&amp;vals.s) == 122<br>
        PASS: test_uatomic 31 - v == 121<br>
        PASS: test_uatomic 32 - uatomic_read(&amp;vals.s) == 119<br>
        PASS: test_uatomic 33 - uatomic_read(&amp;vals.s) == 121<br>
        PASS: test_uatomic 34 - uatomic_read(&amp;vals.s) == 1<br>
        # test_uatomic: Test atomic ops on int<br>
        PASS: test_uatomic 35 - uatomic_read(&amp;vals.i) == 10<br>
        PASS: test_uatomic 36 - uatomic_read(&amp;vals.i) ==
        (__typeof__(*(&amp;vals.i)))-1UL<br>
        PASS: test_uatomic 37 - uatomic_read(&amp;vals.i) == 22<br>
        PASS: test_uatomic 38 - v == (__typeof__(*(&amp;vals.i)))-1UL<br>
        PASS: test_uatomic 39 - uatomic_read(&amp;vals.i) == 22<br>
        PASS: test_uatomic 40 - v == 22<br>
        PASS: test_uatomic 41 - uatomic_read(&amp;vals.i) == 55<br>
        PASS: test_uatomic 42 - v == 22<br>
        PASS: test_uatomic 43 - uatomic_read(&amp;vals.i) == 23<br>
        PASS: test_uatomic 44 - uatomic_read(&amp;vals.i) == 22<br>
        PASS: test_uatomic 45 - v == 96<br>
        PASS: test_uatomic 46 - uatomic_read(&amp;vals.i) == 96<br>
        PASS: test_uatomic 47 - uatomic_read(&amp;vals.i) == 122<br>
        PASS: test_uatomic 48 - v == 121<br>
        PASS: test_uatomic 49 - uatomic_read(&amp;vals.i) == 119<br>
        PASS: test_uatomic 50 - uatomic_read(&amp;vals.i) == 121<br>
        PASS: test_uatomic 51 - uatomic_read(&amp;vals.i) == 1<br>
        # test_uatomic: Test atomic ops on long<br>
        PASS: test_uatomic 52 - uatomic_read(&amp;vals.l) == 10<br>
        PASS: test_uatomic 53 - uatomic_read(&amp;vals.l) ==
        (__typeof__(*(&amp;vals.l)))-1UL<br>
        PASS: test_uatomic 54 - uatomic_read(&amp;vals.l) == 22<br>
        PASS: test_uatomic 55 - v == (__typeof__(*(&amp;vals.l)))-1UL<br>
        PASS: test_uatomic 56 - uatomic_read(&amp;vals.l) == 22<br>
        PASS: test_uatomic 57 - v == 22<br>
        PASS: test_uatomic 58 - uatomic_read(&amp;vals.l) == 55<br>
        PASS: test_uatomic 59 - v == 22<br>
        PASS: test_uatomic 60 - uatomic_read(&amp;vals.l) == 23<br>
        PASS: test_uatomic 61 - uatomic_read(&amp;vals.l) == 22<br>
        PASS: test_uatomic 62 - v == 96<br>
        PASS: test_uatomic 63 - uatomic_read(&amp;vals.l) == 96<br>
        PASS: test_uatomic 64 - uatomic_read(&amp;vals.l) == 122<br>
        PASS: test_uatomic 65 - v == 121<br>
        PASS: test_uatomic 66 - uatomic_read(&amp;vals.l) == 119<br>
        PASS: test_uatomic 67 - uatomic_read(&amp;vals.l) == 121<br>
        PASS: test_uatomic 68 - uatomic_read(&amp;vals.l) == 1<br>
        # test_uatomic_cxx: Test atomic ops on byte<br>
        PASS: test_uatomic_cxx 1 - uatomic_read(&amp;vals.c) == 10<br>
        PASS: test_uatomic_cxx 2 - uatomic_read(&amp;vals.c) ==
        (__typeof__(*(&amp;vals.c)))-1UL<br>
        PASS: test_uatomic_cxx 3 - uatomic_read(&amp;vals.c) == 22<br>
        PASS: test_uatomic_cxx 4 - v == (__typeof__(*(&amp;vals.c)))-1UL<br>
        PASS: test_uatomic_cxx 5 - uatomic_read(&amp;vals.c) == 22<br>
        PASS: test_uatomic_cxx 6 - v == 22<br>
        PASS: test_uatomic_cxx 7 - uatomic_read(&amp;vals.c) == 55<br>
        PASS: test_uatomic_cxx 8 - v == 22<br>
        PASS: test_uatomic_cxx 9 - uatomic_read(&amp;vals.c) == 23<br>
        PASS: test_uatomic_cxx 10 - uatomic_read(&amp;vals.c) == 22<br>
        PASS: test_uatomic_cxx 11 - v == 96<br>
        PASS: test_uatomic_cxx 12 - uatomic_read(&amp;vals.c) == 96<br>
        PASS: test_uatomic_cxx 13 - uatomic_read(&amp;vals.c) == 122<br>
        PASS: test_uatomic_cxx 14 - v == 121<br>
        PASS: test_uatomic_cxx 15 - uatomic_read(&amp;vals.c) == 119<br>
        PASS: test_uatomic_cxx 16 - uatomic_read(&amp;vals.c) == 121<br>
        PASS: test_uatomic_cxx 17 - uatomic_read(&amp;vals.c) == 1<br>
        # test_uatomic_cxx: Test atomic ops on short<br>
        PASS: test_uatomic_cxx 18 - uatomic_read(&amp;vals.s) == 10<br>
        PASS: test_uatomic_cxx 19 - uatomic_read(&amp;vals.s) ==
        (__typeof__(*(&amp;vals.s)))-1UL<br>
        PASS: test_uatomic_cxx 20 - uatomic_read(&amp;vals.s) == 22<br>
        PASS: test_uatomic_cxx 21 - v ==
        (__typeof__(*(&amp;vals.s)))-1UL<br>
        PASS: test_uatomic_cxx 22 - uatomic_read(&amp;vals.s) == 22<br>
        PASS: test_uatomic_cxx 23 - v == 22<br>
        PASS: test_uatomic_cxx 24 - uatomic_read(&amp;vals.s) == 55<br>
        PASS: test_uatomic_cxx 25 - v == 22<br>
        PASS: test_uatomic_cxx 26 - uatomic_read(&amp;vals.s) == 23<br>
        PASS: test_uatomic_cxx 27 - uatomic_read(&amp;vals.s) == 22<br>
        PASS: test_uatomic_cxx 28 - v == 96<br>
        PASS: test_uatomic_cxx 29 - uatomic_read(&amp;vals.s) == 96<br>
        PASS: test_uatomic_cxx 30 - uatomic_read(&amp;vals.s) == 122<br>
        PASS: test_uatomic_cxx 31 - v == 121<br>
        PASS: test_uatomic_cxx 32 - uatomic_read(&amp;vals.s) == 119<br>
        PASS: test_uatomic_cxx 33 - uatomic_read(&amp;vals.s) == 121<br>
        PASS: test_uatomic_cxx 34 - uatomic_read(&amp;vals.s) == 1<br>
        # test_uatomic_cxx: Test atomic ops on int<br>
        PASS: test_uatomic_cxx 35 - uatomic_read(&amp;vals.i) == 10<br>
        PASS: test_uatomic_cxx 36 - uatomic_read(&amp;vals.i) ==
        (__typeof__(*(&amp;vals.i)))-1UL<br>
        PASS: test_uatomic_cxx 37 - uatomic_read(&amp;vals.i) == 22<br>
        PASS: test_uatomic_cxx 38 - v ==
        (__typeof__(*(&amp;vals.i)))-1UL<br>
        PASS: test_uatomic_cxx 39 - uatomic_read(&amp;vals.i) == 22<br>
        PASS: test_uatomic_cxx 40 - v == 22<br>
        PASS: test_uatomic_cxx 41 - uatomic_read(&amp;vals.i) == 55<br>
        PASS: test_uatomic_cxx 42 - v == 22<br>
        PASS: test_uatomic_cxx 43 - uatomic_read(&amp;vals.i) == 23<br>
        PASS: test_uatomic_cxx 44 - uatomic_read(&amp;vals.i) == 22<br>
        PASS: test_uatomic_cxx 45 - v == 96<br>
        PASS: test_uatomic_cxx 46 - uatomic_read(&amp;vals.i) == 96<br>
        PASS: test_uatomic_cxx 47 - uatomic_read(&amp;vals.i) == 122<br>
        PASS: test_uatomic_cxx 48 - v == 121<br>
        PASS: test_uatomic_cxx 49 - uatomic_read(&amp;vals.i) == 119<br>
        PASS: test_uatomic_cxx 50 - uatomic_read(&amp;vals.i) == 121<br>
        PASS: test_uatomic_cxx 51 - uatomic_read(&amp;vals.i) == 1<br>
        # test_uatomic_cxx: Test atomic ops on long<br>
        PASS: test_uatomic_cxx 52 - uatomic_read(&amp;vals.l) == 10<br>
        PASS: test_uatomic_cxx 53 - uatomic_read(&amp;vals.l) ==
        (__typeof__(*(&amp;vals.l)))-1UL<br>
        PASS: test_uatomic_cxx 54 - uatomic_read(&amp;vals.l) == 22<br>
        PASS: test_uatomic_cxx 55 - v ==
        (__typeof__(*(&amp;vals.l)))-1UL<br>
        PASS: test_uatomic_cxx 56 - uatomic_read(&amp;vals.l) == 22<br>
        PASS: test_uatomic_cxx 57 - v == 22<br>
        PASS: test_uatomic_cxx 58 - uatomic_read(&amp;vals.l) == 55<br>
        PASS: test_uatomic_cxx 59 - v == 22<br>
        PASS: test_uatomic_cxx 60 - uatomic_read(&amp;vals.l) == 23<br>
        PASS: test_uatomic_cxx 61 - uatomic_read(&amp;vals.l) == 22<br>
        PASS: test_uatomic_cxx 62 - v == 96<br>
        PASS: test_uatomic_cxx 63 - uatomic_read(&amp;vals.l) == 96<br>
        PASS: test_uatomic_cxx 64 - uatomic_read(&amp;vals.l) == 122<br>
        PASS: test_uatomic_cxx 65 - v == 121<br>
        PASS: test_uatomic_cxx 66 - uatomic_read(&amp;vals.l) == 119<br>
        PASS: test_uatomic_cxx 67 - uatomic_read(&amp;vals.l) == 121<br>
        PASS: test_uatomic_cxx 68 - uatomic_read(&amp;vals.l) == 1<br>
        ERROR: test_urcu_multiflavor - too few tests run (expected 5,
        got 0)<br>
        ERROR: test_urcu_multiflavor - exited with status 134
        (terminated by signal 6?)<br>
        ERROR: test_urcu_multiflavor_cxx - too few tests run (expected
        5, got 0)<br>
        ERROR: test_urcu_multiflavor_cxx - exited with status 134
        (terminated by signal 6?)<br>
        ERROR: test_urcu_multiflavor_dynlink - too few tests run
        (expected 5, got 0)<br>
        ERROR: test_urcu_multiflavor_dynlink - exited with status 134
        (terminated by signal 6?)<br>
        ERROR: test_urcu_multiflavor_dynlink_cxx - too few tests run
        (expected 5, got 0)<br>
        ERROR: test_urcu_multiflavor_dynlink_cxx - exited with status
        134 (terminated by signal 6?)<br>
        PASS: test_urcu_multiflavor_single_unit 1 - !test_mf_mb()<br>
        PASS: test_urcu_multiflavor_single_unit 2 - !test_mf_bp()<br>
        ERROR: test_urcu_multiflavor_single_unit - too few tests run
        (expected 5, got 2)<br>
        ERROR: test_urcu_multiflavor_single_unit - exited with status
        134 (terminated by signal 6?)<br>
        PASS: test_urcu_multiflavor_single_unit_cxx 1 - !test_mf_mb()<br>
        PASS: test_urcu_multiflavor_single_unit_cxx 2 - !test_mf_bp()<br>
        ERROR: test_urcu_multiflavor_single_unit_cxx - too few tests run
        (expected 5, got 2)<br>
        ERROR: test_urcu_multiflavor_single_unit_cxx - exited with
        status 134 (terminated by signal 6?)<br>
        PASS: test_urcu_multiflavor_single_unit_dynlink 1 -
        !test_mf_mb()<br>
        PASS: test_urcu_multiflavor_single_unit_dynlink 2 -
        !test_mf_bp()<br>
        ERROR: test_urcu_multiflavor_single_unit_dynlink - too few tests
        run (expected 5, got 2)<br>
        ERROR: test_urcu_multiflavor_single_unit_dynlink - exited with
        status 134 (terminated by signal 6?)<br>
        PASS: test_urcu_multiflavor_single_unit_dynlink_cxx 1 -
        !test_mf_mb()<br>
        PASS: test_urcu_multiflavor_single_unit_dynlink_cxx 2 -
        !test_mf_bp()<br>
        ERROR: test_urcu_multiflavor_single_unit_dynlink_cxx - too few
        tests run (expected 5, got 2)<br>
        ERROR: test_urcu_multiflavor_single_unit_dynlink_cxx - exited
        with status 134 (terminated by signal 6?)<br>
        PASS: test_build 1 - cds_lfs_empty<br>
        PASS: test_build 2 - cds_lfs_empty<br>
        PASS: test_build 3 - cds_wfcq_empty<br>
        PASS: test_build_cxx 1 - cds_lfs_empty<br>
        PASS: test_build_cxx 2 - cds_lfs_empty<br>
        PASS: test_build_cxx 3 - cds_wfcq_empty<br>
        PASS: test_build_dynlink 1 - cds_lfs_empty<br>
        PASS: test_build_dynlink 2 - cds_lfs_empty<br>
        PASS: test_build_dynlink 3 - cds_wfcq_empty<br>
        PASS: test_build_dynlink_cxx 1 - cds_lfs_empty<br>
        PASS: test_build_dynlink_cxx 2 - cds_lfs_empty<br>
        PASS: test_build_dynlink_cxx 3 - cds_wfcq_empty<br>
============================================================================<br>
        Testsuite summary for userspace-rcu 0.14.0<br>
============================================================================<br>
        # TOTAL: 292<br>
        # PASS:  276<br>
        # SKIP:  0<br>
        # XFAIL: 0<br>
        # FAIL:  0<br>
        # XPASS: 0<br>
        # ERROR: 16<br>
============================================================================<br>
        See tests/unit/test-suite.log<br>
        Please report to mathieu dot desnoyers at efficios dot com<br>
============================================================================<br>
        make[4]: *** [Makefile:1486: test-suite.log] Error 1<br>
        make[4]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/tests/unit'<br>
        make[3]: *** [Makefile:1594: check-TESTS] Error 2<br>
        make[3]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/tests/unit'<br>
        make[2]: *** [Makefile:1828: check-am] Error 2<br>
        make[2]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/tests/unit'<br>
        make[1]: *** [Makefile:382: check-recursive] Error 1<br>
        make[1]: Leaving directory
        '/mnt/Git/apt-build/build/liburcu-0.14.0/tests'<br>
        make: *** [Makefile:491: check-recursive] Error 1<br>
        <br>
      </font></p>
    <p><font face="Ubuntu Mono"></font><br>
    </p>
  </body>
</html>

--------------KF0zW7IotLyc1jf1act854Dv--

--------------YRxpbhoRI0ad0ue0ttEFfsYv
Content-Type: text/plain; charset=UTF-8; name="my_system.txt"
Content-Disposition: attachment; filename="my_system.txt"
Content-Transfer-Encoding: base64

YWxleGVpQEFzcGlyZTp+JCB1bmFtZSAtYQpMaW51eCBBc3BpcmUgNS4xNS43OSAjNiBTTVAg
RnJpIEF1ZyAyNSAxMzo1NjozMyArMDggMjAyMyB4ODZfNjQgR05VL0xpbnV4CgphbGV4ZWlA
QXNwaXJlOn4kIGxzYl9yZWxlYXNlIC1hCk5vIExTQiBtb2R1bGVzIGFyZSBhdmFpbGFibGUu
CkRpc3RyaWJ1dG9yIElEOglMaW51eG1pbnQKRGVzY3JpcHRpb246CUxpbnV4IE1pbnQgMjAu
MwpSZWxlYXNlOgkyMC4zCkNvZGVuYW1lOgl1bmEKCmFsZXhlaUBBc3BpcmU6fiQgYXJjaAp4
ODZfNjQKCmFsZXhlaUBBc3BpcmU6fiQgaG9zdG5hbWVjdGwKICAgU3RhdGljIGhvc3RuYW1l
OiBBc3BpcmUKICAgICAgICAgSWNvbiBuYW1lOiBjb21wdXRlci1sYXB0b3AKICAgICAgICAg
ICBDaGFzc2lzOiBsYXB0b3AKICAgICAgICBNYWNoaW5lIElEOiAwOTE0M2QwMjYxYmU0ODcz
ODBhOWVjOWJmNDFkNTkyMgogICAgICAgICAgIEJvb3QgSUQ6IGZmOWVkNzQ0OTM2ZjQxNjc5
MDg3M2ZhMTRmMGY1Y2IzCiAgT3BlcmF0aW5nIFN5c3RlbTogTGludXggTWludCAyMC4zCiAg
ICAgICAgICAgIEtlcm5lbDogTGludXggNS4xNS43OQogICAgICBBcmNoaXRlY3R1cmU6IHg4
Ni02NAoKYWxleGVpQEFzcGlyZTp+JCBleHBvcnQKZGVjbGFyZSAteCBBQ0xPQ0FMX1BBVEg9
Ii91c3IvbG9jYWwvc2hhcmUvYWNsb2NhbDovdXNyL3NoYXJlL2FjbG9jYWwiCmRlY2xhcmUg
LXggQU5UX0hPTUU9Ii90b29scy9hbnQtMS4xMC4xMyIKZGVjbGFyZSAtcnggQWxsUmVwb3Np
dG9yaWVzTGlzdD0iL2hvbWUvYWxleGVpL3NjcmlwdHMvY29tcGlsZS9BbGxSZXBvc2l0b3Jp
ZXMudHh0IgpkZWNsYXJlIC1yeCBCQVNIX0ZVTkNUSU9OX0xJQlJBUlk9Ii9ldGMvYmFzaF9m
dW5jdGlvbnNfbGlicmFyeS9hdXRvbG9hZC5zaCIKZGVjbGFyZSAteCBDQz0iY2NhY2hlIGdj
YyIKZGVjbGFyZSAteCBDQ0FDSEVfRElSPSIvdmFyL2NhY2hlLy5jY2FjaGUiCmRlY2xhcmUg
LXggQ0xBU1NQQVRIPSIvb3B0L3NheG9uL3NheG9uLmphciIKZGVjbGFyZSAteCBDTUFLRV9N
T0RVTEVfUEFUSD0iL3Vzci9sb2NhbC9zaGFyZS9jbWFrZS0zLjI0L01vZHVsZXMiCmRlY2xh
cmUgLXggQ09MT1JURVJNPSJ0cnVlY29sb3IiCmRlY2xhcmUgLXggQ1BQX0lOQ0xVREVfUEFU
SD0iL3Vzci9sb2NhbC9pbmNsdWRlOi91c3Ivc3JjL2xpbnV4LTUuMTUuNzkvaW5jbHVkZTov
dXNyL2luY2x1ZGU6L3Vzci9pbmNsdWRlL3g4Nl82NC1saW51eC1nbnUiCmRlY2xhcmUgLXgg
Q19JTkNMVURFX1BBVEg9Ii91c3IvbG9jYWwvaW5jbHVkZTovdXNyL3NyYy9saW51eC01LjE1
Ljc5L2luY2x1ZGU6L3Vzci9pbmNsdWRlOi91c3IvaW5jbHVkZS94ODZfNjQtbGludXgtZ251
IgpkZWNsYXJlIC1yeCBDcmVhdGVDb250cm9sU2NyaXB0c0ZvbGRlclBhdGg9Ii9ob21lL2Fs
ZXhlaS9zY3JpcHRzL2NvbXBpbGUvY3JlYXRlY29udHJvbCIKZGVjbGFyZSAteCBEQlVTX1NF
U1NJT05fQlVTX0FERFJFU1M9InVuaXg6cGF0aD0vcnVuL3VzZXIvMTAwMC9idXMiCmRlY2xh
cmUgLXggREVTS1RPUF9BVVRPU1RBUlRfSUQ9IjEwZDRjM2E5NDE2MWEzYmUxMjE2OTMxNzk3
MDAxNTQ2NzQwMDAwMDAxMzUxMDAyNyIKZGVjbGFyZSAteCBERVNLVE9QX1NFU1NJT049ImNp
bm5hbW9uIgpkZWNsYXJlIC14IERJU1BMQVk9IjowIgpkZWNsYXJlIC14IEdETVNFU1NJT049
ImNpbm5hbW9uIgpkZWNsYXJlIC14IEdETV9MQU5HPSJydSIKZGVjbGFyZSAteCBHRU1fUEFU
SD0iL2hvbWUvYWxleGVpLy5nZW1zOi91c3IvbG9jYWwvbGliL3J1YnkvZ2Vtcy8zLjEuMCIK
ZGVjbGFyZSAteCBHSV9UWVBFTElCX1BBVEg9Ii91c3IvbG9jYWwvbGliL2dpcmVwb3NpdG9y
eS0xLjAiCmRlY2xhcmUgLXggR05PTUVfREVTS1RPUF9TRVNTSU9OX0lEPSJ0aGlzLWlzLWRl
cHJlY2F0ZWQiCmRlY2xhcmUgLXggR05PTUVfVEVSTUlOQUxfU0NSRUVOPSIvb3JnL2dub21l
L1Rlcm1pbmFsL3NjcmVlbi9jNGJmYzk1Y18yMWU2XzRiODJfOWRlMl83MDQxMjEzMTI3Zjki
CmRlY2xhcmUgLXggR05PTUVfVEVSTUlOQUxfU0VSVklDRT0iOjEuMTIyIgpkZWNsYXJlIC14
IEdPUEFUSD0iL3Vzci9sb2NhbC9iaW4iCmRlY2xhcmUgLXggR09ST09UX0JPT1RTVFJBUD0i
L21udC9HaXQvbGFuZ3MvZ28tMS4xOS4yIgpkZWNsYXJlIC14IEdPVE9fTlVNX1RIUkVBRFM9
IjQiCmRlY2xhcmUgLXggR1BHX0FHRU5UX0lORk89Ii9ydW4vdXNlci8xMDAwL2dudXBnL1Mu
Z3BnLWFnZW50OjA6MSIKZGVjbGFyZSAteCBHUEdfVFRZPSIvZGV2L3B0cy8wIgpkZWNsYXJl
IC14IEdUSzNfTU9EVUxFUz0ieGFwcC1ndGszLW1vZHVsZSIKZGVjbGFyZSAteCBHVEtfTU9E
VUxFUz0iZ2FpbDphdGstYnJpZGdlIgpkZWNsYXJlIC14IEdUS19PVkVSTEFZX1NDUk9MTElO
Rz0iMSIKZGVjbGFyZSAteCBISVNURklMRT0iL2hvbWUvYWxleGVpLy5iYXNoX2V0ZXJuYWxf
aGlzdG9yeSIKZGVjbGFyZSAteCBISVNURklMRVNJWkU9IiIKZGVjbGFyZSAteCBISVNUSUdO
T1JFPSImOltiZl1nOmV4aXQiCmRlY2xhcmUgLXggSElTVFNJWkU9IiIKZGVjbGFyZSAteCBI
T01FPSIvaG9tZS9hbGV4ZWkiCmRlY2xhcmUgLXggSE9TVENDPSJjY2FjaGUgZ2NjIgpkZWNs
YXJlIC14IEhPU1RDWFg9ImNjYWNoZSBnKysiCmRlY2xhcmUgLXggSU5QVVRSQz0iL2V0Yy9p
bnB1dHJjIgpkZWNsYXJlIC14IEpBVkFfSE9NRT0iL29wdC9qZGsiCmRlY2xhcmUgLXggTEFO
Rz0icnVfUlUuVVRGLTgiCmRlY2xhcmUgLXggTEFOR1VBR0U9InJ1X1JVIgpkZWNsYXJlIC14
IExDX0FERFJFU1M9InJ1X1JVLlVURi04IgpkZWNsYXJlIC14IExDX0lERU5USUZJQ0FUSU9O
PSJydV9SVS5VVEYtOCIKZGVjbGFyZSAteCBMQ19NRUFTVVJFTUVOVD0icnVfUlUuVVRGLTgi
CmRlY2xhcmUgLXggTENfTU9ORVRBUlk9InJ1X1JVLlVURi04IgpkZWNsYXJlIC14IExDX05B
TUU9InJ1X1JVLlVURi04IgpkZWNsYXJlIC14IExDX05VTUVSSUM9InJ1X1JVLlVURi04Igpk
ZWNsYXJlIC14IExDX1BBUEVSPSJydV9SVS5VVEYtOCIKZGVjbGFyZSAteCBMQ19URUxFUEhP
TkU9InJ1X1JVLlVURi04IgpkZWNsYXJlIC14IExDX1RJTUU9InJ1X1JVLlVURi04IgpkZWNs
YXJlIC14IExEX0xJQlJBUllfUEFUSD0iL3Vzci9sb2NhbC9saWI6L3Vzci9sb2NhbC9saWIv
eDg2XzY0LWxpbnV4LWdudTovaG9tZS9hbGV4ZWkvLmxvY2FsL2xpYjovdXNyL2xpYjovdXNy
L2xpYi94ODZfNjQtbGludXgtZ251IgpkZWNsYXJlIC14IExFU1NDTE9TRT0iL3Vzci9iaW4v
bGVzc3BpcGUgJXMgJXMiCmRlY2xhcmUgLXggTEVTU09QRU49InwgL3Vzci9iaW4vbGVzc3Bp
cGUgJXMiCmRlY2xhcmUgLXggTElCUkFSWV9QQVRIPSIvdXNyL2xvY2FsL2xpYjovdXNyL2xv
Y2FsL2xpYi94ODZfNjQtbGludXgtZ251Oi9ob21lL2FsZXhlaS8ubG9jYWwvbGliOi91c3Iv
bGliOi91c3IvbGliL3g4Nl82NC1saW51eC1nbnUiCmRlY2xhcmUgLXggTElCVklSVF9ERUZB
VUxUX1VSST0icWVtdTovLy9zeXN0ZW0iCmRlY2xhcmUgLXggTE9HTkFNRT0iYWxleGVpIgpk
ZWNsYXJlIC14IExTX0NPTE9SUz0icnM9MDpkaT0wMTszNDpsbj0wMTszNjptaD0wMDpwaT00
MDszMzpzbz0wMTszNTpkbz0wMTszNTpiZD00MDszMzswMTpjZD00MDszMzswMTpvcj00MDsz
MTswMTptaT0wMDpzdT0zNzs0MTpzZz0zMDs0MzpjYT0zMDs0MTp0dz0zMDs0Mjpvdz0zNDs0
MjpzdD0zNzs0NDpleD0wMTszMjoqLnRhcj0wMTszMToqLnRnej0wMTszMToqLmFyYz0wMTsz
MToqLmFyaj0wMTszMToqLnRhej0wMTszMToqLmxoYT0wMTszMToqLmx6ND0wMTszMToqLmx6
aD0wMTszMToqLmx6bWE9MDE7MzE6Ki50bHo9MDE7MzE6Ki50eHo9MDE7MzE6Ki50em89MDE7
MzE6Ki50N3o9MDE7MzE6Ki56aXA9MDE7MzE6Ki56PTAxOzMxOiouZHo9MDE7MzE6Ki5nej0w
MTszMToqLmxyej0wMTszMToqLmx6PTAxOzMxOioubHpvPTAxOzMxOioueHo9MDE7MzE6Ki56
c3Q9MDE7MzE6Ki50enN0PTAxOzMxOiouYnoyPTAxOzMxOiouYno9MDE7MzE6Ki50Yno9MDE7
MzE6Ki50YnoyPTAxOzMxOioudHo9MDE7MzE6Ki5kZWI9MDE7MzE6Ki5ycG09MDE7MzE6Ki5q
YXI9MDE7MzE6Ki53YXI9MDE7MzE6Ki5lYXI9MDE7MzE6Ki5zYXI9MDE7MzE6Ki5yYXI9MDE7
MzE6Ki5hbHo9MDE7MzE6Ki5hY2U9MDE7MzE6Ki56b289MDE7MzE6Ki5jcGlvPTAxOzMxOiou
N3o9MDE7MzE6Ki5yej0wMTszMToqLmNhYj0wMTszMToqLndpbT0wMTszMToqLnN3bT0wMTsz
MToqLmR3bT0wMTszMToqLmVzZD0wMTszMToqLmpwZz0wMTszNToqLmpwZWc9MDE7MzU6Ki5t
anBnPTAxOzM1OioubWpwZWc9MDE7MzU6Ki5naWY9MDE7MzU6Ki5ibXA9MDE7MzU6Ki5wYm09
MDE7MzU6Ki5wZ209MDE7MzU6Ki5wcG09MDE7MzU6Ki50Z2E9MDE7MzU6Ki54Ym09MDE7MzU6
Ki54cG09MDE7MzU6Ki50aWY9MDE7MzU6Ki50aWZmPTAxOzM1OioucG5nPTAxOzM1Oiouc3Zn
PTAxOzM1Oiouc3Znej0wMTszNToqLm1uZz0wMTszNToqLnBjeD0wMTszNToqLm1vdj0wMTsz
NToqLm1wZz0wMTszNToqLm1wZWc9MDE7MzU6Ki5tMnY9MDE7MzU6Ki5ta3Y9MDE7MzU6Ki53
ZWJtPTAxOzM1Oioub2dtPTAxOzM1OioubXA0PTAxOzM1OioubTR2PTAxOzM1OioubXA0dj0w
MTszNToqLnZvYj0wMTszNToqLnF0PTAxOzM1OioubnV2PTAxOzM1Oioud212PTAxOzM1Oiou
YXNmPTAxOzM1Oioucm09MDE7MzU6Ki5ybXZiPTAxOzM1OiouZmxjPTAxOzM1OiouYXZpPTAx
OzM1OiouZmxpPTAxOzM1OiouZmx2PTAxOzM1OiouZ2w9MDE7MzU6Ki5kbD0wMTszNToqLnhj
Zj0wMTszNToqLnh3ZD0wMTszNToqLnl1dj0wMTszNToqLmNnbT0wMTszNToqLmVtZj0wMTsz
NToqLm9ndj0wMTszNToqLm9neD0wMTszNToqLmFhYz0wMDszNjoqLmF1PTAwOzM2OiouZmxh
Yz0wMDszNjoqLm00YT0wMDszNjoqLm1pZD0wMDszNjoqLm1pZGk9MDA7MzY6Ki5ta2E9MDA7
MzY6Ki5tcDM9MDA7MzY6Ki5tcGM9MDA7MzY6Ki5vZ2c9MDA7MzY6Ki5yYT0wMDszNjoqLndh
dj0wMDszNjoqLm9nYT0wMDszNjoqLm9wdXM9MDA7MzY6Ki5zcHg9MDA7MzY6Ki54c3BmPTAw
OzM2OiIKZGVjbGFyZSAteCBNQU5QQVRIPSIvb3B0L2pkay9tYW4iCmRlY2xhcmUgLXggTklY
X1BST0ZJTEVTPSIvbml4L3Zhci9uaXgvcHJvZmlsZXMvZGVmYXVsdCAvaG9tZS9hbGV4ZWkv
Lm5peC1wcm9maWxlIgpkZWNsYXJlIC14IE5JWF9TU0xfQ0VSVF9GSUxFPSIvZXRjL3NzbC9j
ZXJ0cy9jYS1jZXJ0aWZpY2F0ZXMuY3J0IgpkZWNsYXJlIC14IE9MRFBXRD0iL2hvbWUvYWxl
eGVpL2J1aWxkL2dsaWJjLTIuMzEiCmRlY2xhcmUgLXggT01QX05VTV9USFJFQURTPSI0Igpk
ZWNsYXJlIC14IE9QRU5CTEFTX05VTV9USFJFQURTPSI0IgpkZWNsYXJlIC14IFBBSE9MRT0i
L3Vzci9sb2NhbC9iaW4vcGFob2xlIgpkZWNsYXJlIC14IFBBUEVSU0laRT0iYTQiCmRlY2xh
cmUgLXggUEFUSD0iL3Vzci9sb2NhbC9iaW46L2hvbWUvYWxleGVpLy5sb2NhbC9iaW46L3Vz
ci9sb2NhbC9zYmluOi91c3Ivc2JpbjovaG9tZS9hbGV4ZWkvLm5peC1wcm9maWxlL2Jpbjov
bml4L3Zhci9uaXgvcHJvZmlsZXMvZGVmYXVsdC9iaW46L3Vzci9iaW46L29wdC9HTkFULzIw
MjEvYmluOi9vcHQvYmF6ZWwvYmluOi9vcHQvZ3JhZGxlL2Jpbjovc25hcC9iaW4iCmRlY2xh
cmUgLXggUEtHX0NPTkZJR19QQVRIPSIvdXNyL2xvY2FsL2xpYi9wa2djb25maWc6L3Vzci9s
b2NhbC9saWIveDg2XzY0LWxpbnV4LWdudS9wa2djb25maWc6L3Vzci9saWIvcGtnY29uZmln
Oi91c3IvbGliL3g4Nl82NC1saW51eC1nbnUvcGtnY29uZmlnIgpkZWNsYXJlIC14IFBTMT0i
XFxbXFxlXTA7XFx1QFxcaDogXFx3XFxhXFxdXCR7ZGViaWFuX2Nocm9vdDorKFwkZGViaWFu
X2Nocm9vdCl9XFwwMzNbMTszMm1cXHVAXFxoXFwwMzNbMG06XFwwMzNbMTszNG1cXHdcXDAz
M1swbVwkICIKZGVjbGFyZSAteCBQV0Q9Ii9ob21lL2FsZXhlaS9idWlsZC9nbGliYy0yLjMx
L215YnVpbGQiCmRlY2xhcmUgLXggUFlUSE9OUEFUSD0iL2hvbWUvYWxleGVpLy5sb2NhbC9s
aWIvcHl0aG9uMy44L3NpdGUtcGFja2FnZXM6L2hvbWUvYWxleGVpLy5sb2NhbC9saWIvcHl0
aG9uMy44L2Rpc3QtcGFja2FnZXM6L3Vzci9saWIvcHl0aG9uMy9kaXN0LXBhY2thZ2VzOi91
c3IvbGliL3B5dGhvbjMuOC9kaXN0LXBhY2thZ2VzIgpkZWNsYXJlIC1yeCBQYWNrYWdlc0xp
c3Q9InBrZ3NsaXN0IgpkZWNsYXJlIC1yeCBQb3N0cm1TY3JpcHRzRm9sZGVyUGF0aD0iL2hv
bWUvYWxleGVpL3NjcmlwdHMvY29tcGlsZS9wb3N0cm0iCmRlY2xhcmUgLXJ4IFByZWluc3RT
Y3JpcHRzRm9sZGVyUGF0aD0iL2hvbWUvYWxleGVpL3NjcmlwdHMvY29tcGlsZS9wcmVpbnN0
IgpkZWNsYXJlIC14IFFUX0FDQ0VTU0lCSUxJVFk9IjEiCmRlY2xhcmUgLXggUVRfUVBBX1BM
QVRGT1JNVEhFTUU9InF0NWN0IgpkZWNsYXJlIC14IFNFU1NJT05fTUFOQUdFUj0ibG9jYWwv
QXNwaXJlOkAvdG1wLy5JQ0UtdW5peC8xMzUxLHVuaXgvQXNwaXJlOi90bXAvLklDRS11bml4
LzEzNTEiCmRlY2xhcmUgLXggU0hFTEw9Ii9iaW4vYmFzaCIKZGVjbGFyZSAteCBTSExWTD0i
MSIKZGVjbGFyZSAteCBTU0hfQUdFTlRfUElEPSIyMjk1IgpkZWNsYXJlIC14IFNTSF9BVVRI
X1NPQ0s9Ii9ydW4vdXNlci8xMDAwL2tleXJpbmcvc3NoIgpkZWNsYXJlIC14IFRFUk09Inh0
ZXJtLTI1NmNvbG9yIgpkZWNsYXJlIC14IFRFWExJVkVfUFJFRklYPSIvb3B0L3RleGxpdmUv
MjAyMyIKZGVjbGFyZSAteCBVU0VSPSJhbGV4ZWkiCmRlY2xhcmUgLXggVlRFX1ZFUlNJT049
IjYwMDMiCmRlY2xhcmUgLXggWEFVVEhPUklUWT0iL2hvbWUvYWxleGVpLy5YYXV0aG9yaXR5
IgpkZWNsYXJlIC14IFhER19DT05GSUdfRElSUz0iL2V0Yy94ZGcveGRnLWNpbm5hbW9uOi9l
dGMveGRnIgpkZWNsYXJlIC14IFhER19DVVJSRU5UX0RFU0tUT1A9IlgtQ2lubmFtb24iCmRl
Y2xhcmUgLXggWERHX0RBVEFfRElSUz0iL3Vzci9zaGFyZS9jaW5uYW1vbjovdXNyL3NoYXJl
L2dub21lOi9ob21lL2FsZXhlaS8ubG9jYWwvc2hhcmUvZmxhdHBhay9leHBvcnRzL3NoYXJl
Oi92YXIvbGliL2ZsYXRwYWsvZXhwb3J0cy9zaGFyZTovdXNyL3NoYXJlOi92YXIvbGliL3Nu
YXBkL2Rlc2t0b3AiCmRlY2xhcmUgLXggWERHX0dSRUVURVJfREFUQV9ESVI9Ii92YXIvbGli
L2xpZ2h0ZG0tZGF0YS9hbGV4ZWkiCmRlY2xhcmUgLXggWERHX1JVTlRJTUVfRElSPSIvcnVu
L3VzZXIvMTAwMCIKZGVjbGFyZSAteCBYREdfU0VBVD0ic2VhdDAiCmRlY2xhcmUgLXggWERH
X1NFQVRfUEFUSD0iL29yZy9mcmVlZGVza3RvcC9EaXNwbGF5TWFuYWdlci9TZWF0MCIKZGVj
bGFyZSAteCBYREdfU0VTU0lPTl9DTEFTUz0idXNlciIKZGVjbGFyZSAteCBYREdfU0VTU0lP
Tl9ERVNLVE9QPSJjaW5uYW1vbiIKZGVjbGFyZSAteCBYREdfU0VTU0lPTl9JRD0iYzEiCmRl
Y2xhcmUgLXggWERHX1NFU1NJT05fUEFUSD0iL29yZy9mcmVlZGVza3RvcC9EaXNwbGF5TWFu
YWdlci9TZXNzaW9uMCIKZGVjbGFyZSAteCBYREdfU0VTU0lPTl9UWVBFPSJ4MTEiCmRlY2xh
cmUgLXggWERHX1ZUTlI9IjciCmRlY2xhcmUgLXggWE9SR19DT05GSUc9Ii0tcHJlZml4PS91
c3IvbG9jYWwgLS1zeXNjb25mZGlyPS9ldGMgLS1sb2NhbHN0YXRlZGlyPS92YXIgLS1kaXNh
YmxlLXN0YXRpYyIKZGVjbGFyZSAteCBYT1JHX1BSRUZJWD0iL3Vzci9sb2NhbCIKZGVjbGFy
ZSAteCBfUElQX1NUQU5EQUxPTkVfQ0VSVD0iL2V0Yy9wa2kvdGxzL2NlcnRzL2NhLWJ1bmRs
ZS5jcnQiCmRlY2xhcmUgLXJ4IGFwdGNhY2hlRGlyZWN0b3J5PSIvdmFyL2NhY2hlL2FwdC9h
cmNoaXZlcyIKZGVjbGFyZSAtcnggYXNrX3N1ZG89InN1ZG8gdGVzdCAtZCAvdG1wIgpkZWNs
YXJlIC1yeCBib290U2NyaXB0c0RpcmVjdG9yeT0iL2hvbWUvYWxleGVpL3NjcmlwdHMvYm9v
dCIKZGVjbGFyZSAtcnggYnVpbGREaXJlY3Rvcnk9Ii9tbnQvR2l0L2FwdC1idWlsZC9idWls
ZCIKZGVjbGFyZSAtcnggZm9yd2FyZExpbmtzU2NyaXB0PSJmb3J3YXJkTGlua3Muc2giCmRl
Y2xhcmUgLXJ4IGxvY2FsUHl0aG9uTW9kdWxlc0Rpcj0iL2hvbWUvYWxleGVpLy5sb2NhbC9s
aWIvcHl0aG9uMy44L3NpdGUtcGFja2FnZXMiCmRlY2xhcmUgLXJ4IG15UGVybD0iNS4zMC4w
IgpkZWNsYXJlIC1yeCBteVB5dGhvbj0icHl0aG9uMy44IgpkZWNsYXJlIC1yeCBwYXRoRXRj
PSIvaG9tZS9hbGV4ZWkvc2NyaXB0cy9ldGMiCmRlY2xhcmUgLXJ4IHBhdGhMRlM9Ii9ob21l
L2FsZXhlaS9zY3JpcHRzL2NvbXBpbGUiCmRlY2xhcmUgLXJ4IHBhdGhSZWNpcGVzPSIvaG9t
ZS9hbGV4ZWkvc2NyaXB0cy9jb21waWxlL29yZGVyLmpzb24iCmRlY2xhcmUgLXJ4IHBhdGhz
SE9NRT0iL2V0Yy9wcm9maWxlLmQvYWRkQ3VzdG9tUGF0aC5zaCIKZGVjbGFyZSAtcnggcmVh
ZEpzb25CeVBlcmxTY3JpcHQ9InBlcmwucGwiCmRlY2xhcmUgLXJ4IHJlYWRQYXRjaEJ5UGVy
bFNjcmlwdD0iZ2V0UGF0Y2gucGwiCmRlY2xhcmUgLXJ4IHJlYWRTY3JpcHRQYXJhbXNDb2Rl
PSIvaG9tZS9hbGV4ZWkvc2NyaXB0cy9jb21waWxlL2dldFNjcmlwdFBhcmFtcwoKYWxleGVp
QEFzcGlyZTp+JCBnY2MgLXYKVXNpbmcgYnVpbHQtaW4gc3BlY3MuCkNPTExFQ1RfR0NDPWdj
YwpDT0xMRUNUX0xUT19XUkFQUEVSPS91c3IvbGliL2djYy94ODZfNjQtbGludXgtZ251Lzkv
bHRvLXdyYXBwZXIKT0ZGTE9BRF9UQVJHRVRfTkFNRVM9bnZwdHgtbm9uZTpoc2EKT0ZGTE9B
RF9UQVJHRVRfREVGQVVMVD0xClRhcmdldDogeDg2XzY0LWxpbnV4LWdudQpDb25maWd1cmVk
IHdpdGg6IC4uL3NyYy9jb25maWd1cmUgLXYgLS13aXRoLXBrZ3ZlcnNpb249J1VidW50dSA5
LjQuMC0xdWJ1bnR1MX4yMC4wNC4xJyAtLXdpdGgtYnVndXJsPWZpbGU6Ly8vdXNyL3NoYXJl
L2RvYy9nY2MtOS9SRUFETUUuQnVncyAtLWVuYWJsZS1sYW5ndWFnZXM9YyxhZGEsYysrLGdv
LGJyaWcsZCxmb3J0cmFuLG9iamMsb2JqLWMrKyxnbTIgLS1wcmVmaXg9L3VzciAtLXdpdGgt
Z2NjLW1ham9yLXZlcnNpb24tb25seSAtLXByb2dyYW0tc3VmZml4PS05IC0tcHJvZ3JhbS1w
cmVmaXg9eDg2XzY0LWxpbnV4LWdudS0gLS1lbmFibGUtc2hhcmVkIC0tZW5hYmxlLWxpbmtl
ci1idWlsZC1pZCAtLWxpYmV4ZWNkaXI9L3Vzci9saWIgLS13aXRob3V0LWluY2x1ZGVkLWdl
dHRleHQgLS1lbmFibGUtdGhyZWFkcz1wb3NpeCAtLWxpYmRpcj0vdXNyL2xpYiAtLWVuYWJs
ZS1ubHMgLS1lbmFibGUtY2xvY2FsZT1nbnUgLS1lbmFibGUtbGlic3RkY3h4LWRlYnVnIC0t
ZW5hYmxlLWxpYnN0ZGN4eC10aW1lPXllcyAtLXdpdGgtZGVmYXVsdC1saWJzdGRjeHgtYWJp
PW5ldyAtLWVuYWJsZS1nbnUtdW5pcXVlLW9iamVjdCAtLWRpc2FibGUtdnRhYmxlLXZlcmlm
eSAtLWVuYWJsZS1wbHVnaW4gLS1lbmFibGUtZGVmYXVsdC1waWUgLS13aXRoLXN5c3RlbS16
bGliIC0td2l0aC10YXJnZXQtc3lzdGVtLXpsaWI9YXV0byAtLWVuYWJsZS1vYmpjLWdjPWF1
dG8gLS1lbmFibGUtbXVsdGlhcmNoIC0tZGlzYWJsZS13ZXJyb3IgLS13aXRoLWFyY2gtMzI9
aTY4NiAtLXdpdGgtYWJpPW02NCAtLXdpdGgtbXVsdGlsaWItbGlzdD1tMzIsbTY0LG14MzIg
LS1lbmFibGUtbXVsdGlsaWIgLS13aXRoLXR1bmU9Z2VuZXJpYyAtLWVuYWJsZS1vZmZsb2Fk
LXRhcmdldHM9bnZwdHgtbm9uZT0vYnVpbGQvZ2NjLTktQXYzdUVkL2djYy05LTkuNC4wL2Rl
Ymlhbi90bXAtbnZwdHgvdXNyLGhzYSAtLXdpdGhvdXQtY3VkYS1kcml2ZXIgLS1lbmFibGUt
Y2hlY2tpbmc9cmVsZWFzZSAtLWJ1aWxkPXg4Nl82NC1saW51eC1nbnUgLS1ob3N0PXg4Nl82
NC1saW51eC1nbnUgLS10YXJnZXQ9eDg2XzY0LWxpbnV4LWdudQpUaHJlYWQgbW9kZWw6IHBv
c2l4CmdjYyB2ZXJzaW9uIDkuNC4wIChVYnVudHUgOS40LjAtMXVidW50dTF+MjAuMDQuMSkK
CmxkIC1WCkdOVSBsZCAoR05VIEJpbnV0aWxzKSAyLjQwCiAg0J/QvtC00LTQtdGA0LbQuNCy
0LDQtdC80YvQtSDRjdC80YPQu9GP0YbQuNC4OgogICBhaXg1cHBjCiAgIGFpeDVyczYKICAg
YWl4cHBjCiAgIGFpeHJzNgogICBhbHBoYQogICBhbHBoYXZtcwogICBhcmNlbGYKICAgYXJj
bGludXgKICAgYXJjbGludXhfbnBzCiAgIGFyY3YyZWxmCiAgIGFyY3YyZWxmeAogICBhcm1f
d2luY2VfcGUKICAgYXJtZWxmCiAgIGFybWVsZl9mYnNkCiAgIGFybWVsZl9mdWNoc2lhCiAg
IGFybWVsZl9oYWlrdQogICBhcm1lbGZfbGludXgKICAgYXJtZWxmX2xpbnV4X2VhYmkKICAg
YXJtZWxmX2xpbnV4X2ZkcGljZWFiaQogICBhcm1lbGZfbmFjbAogICBhcm1lbGZfbmJzZAog
ICBhcm1lbGZfcGhvZW5peAogICBhcm1lbGZfdnh3b3JrcwogICBhcm1lbGZiCiAgIGFybWVs
ZmJfZmJzZAogICBhcm1lbGZiX2Z1Y2hzaWEKICAgYXJtZWxmYl9saW51eAogICBhcm1lbGZi
X2xpbnV4X2VhYmkKICAgYXJtZWxmYl9saW51eF9mZHBpY2VhYmkKICAgYXJtZWxmYl9uYWNs
CiAgIGFybWVsZmJfbmJzZAogICBhcm1udG8KICAgYXJtcGUKICAgYXZyMQogICBhdnIyCiAg
IGF2cjI1CiAgIGF2cjMKICAgYXZyMzEKICAgYXZyMzUKICAgYXZyNAogICBhdnI1CiAgIGF2
cjUxCiAgIGF2cjYKICAgYXZydGlueQogICBhdnJ4bWVnYTEKICAgYXZyeG1lZ2EyCiAgIGF2
cnhtZWdhMwogICBhdnJ4bWVnYTQKICAgYXZyeG1lZ2E1CiAgIGF2cnhtZWdhNgogICBhdnJ4
bWVnYTcKICAgY3Jpc2FvdXQKICAgY3Jpc2VsZgogICBjcmlzbGludXgKICAgY3NreWVsZgog
ICBjc2t5ZWxmX2xpbnV4CiAgIGQxMHZlbGYKICAgZDMwdl9lCiAgIGQzMHZfbwogICBkMzB2
ZWxmCiAgIGVsZjMyX2RseAogICBlbGYzMl9zcGFyYwogICBlbGYzMl9zcGFyY19zb2wyCiAg
IGVsZjMyX3NwYXJjX3Z4d29ya3MKICAgZWxmMzJfc3B1CiAgIGVsZjMyX3RpYzZ4X2JlCiAg
IGVsZjMyX3RpYzZ4X2VsZl9iZQogICBlbGYzMl90aWM2eF9lbGZfbGUKICAgZWxmMzJfdGlj
NnhfbGUKICAgZWxmMzJfdGljNnhfbGludXhfYmUKICAgZWxmMzJfdGljNnhfbGludXhfbGUK
ICAgZWxmMzJhbTMzbGluCiAgIGVsZjMyYmZpbgogICBlbGYzMmJmaW5mZAogICBlbGYzMmNy
MTYKICAgZWxmMzJjcngKICAgZWxmMzJlcGlwaGFueQogICBlbGYzMmVwaXBoYW55XzR4NAog
ICBlbGYzMmZyMzAKICAgZWxmMzJmcnYKICAgZWxmMzJmcnZmZAogICBlbGYzMmZ0MzIKICAg
ZWxmMzJpcDJrCiAgIGVsZjMyaXExMAogICBlbGYzMmlxMjAwMAogICBlbGYzMmxtMzIKICAg
ZWxmMzJsbTMyZmQKICAgZWxmMzJscHBjCiAgIGVsZjMybHBwY2xpbnV4CiAgIGVsZjMybHBw
Y250bwogICBlbGYzMmxwcGNzaW0KICAgZWxmMzJtMzJjCiAgIGVsZjMybWJfbGludXgKICAg
ZWxmMzJtYmVsX2xpbnV4CiAgIGVsZjMybWNvcmUKICAgZWxmMzJtZXAKICAgZWxmMzJtZXRh
ZwogICBlbGYzMm1pY3JvYmxhemUKICAgZWxmMzJtaWNyb2JsYXplZWwKICAgZWxmMzJtb3hp
ZQogICBlbGYzMm10CiAgIGVsZjMyb3IxawogICBlbGYzMm9yMWtfbGludXgKICAgZWxmMzJw
cGMKICAgZWxmMzJwcGNfZmJzZAogICBlbGYzMnBwY2hhaWt1CiAgIGVsZjMycHBjbGludXgK
ICAgZWxmMzJwcGNudG8KICAgZWxmMzJwcGNzaW0KICAgZWxmMzJwcGN2eHdvcmtzCiAgIGVs
ZjMycHBjd2luZGlzcwogICBlbGYzMnJsNzgKICAgZWxmMzJyeAogICBlbGYzMnJ4X2xpbnV4
CiAgIGVsZjMydGlsZWd4CiAgIGVsZjMydGlsZWd4X2JlCiAgIGVsZjMydGlsZXBybwogICBl
bGYzMnZheAogICBlbGYzMnZpc2l1bQogICBlbGYzMnhzdG9ybXkxNgogICBlbGYzMnh0ZW5z
YQogICBlbGYzMno4MAogICBlbGZfaTM4NgogICBlbGZfaTM4Nl9iZQogICBlbGZfaTM4Nl9m
YnNkCiAgIGVsZl9pMzg2X2hhaWt1CiAgIGVsZl9pMzg2X2xkc28KICAgZWxmX2kzODZfc29s
MgogICBlbGZfaTM4Nl92eHdvcmtzCiAgIGVsZl9pYW1jdQogICBlbGZfczM5MAogICBoODMw
MGVsZgogICBoODMwMGVsZl9saW51eAogICBoODMwMGhlbGYKICAgaDgzMDBoZWxmX2xpbnV4
CiAgIGg4MzAwaG5lbGYKICAgaDgzMDBzZWxmCiAgIGg4MzAwc2VsZl9saW51eAogICBoODMw
MHNuZWxmCiAgIGg4MzAwc3hlbGYKICAgaDgzMDBzeGVsZl9saW51eAogICBoODMwMHN4bmVs
ZgogICBocHBhZWxmCiAgIGhwcGFsaW51eAogICBocHBhbmJzZAogICBocHBhb2JzZAogICBp
Mzg2YW91dAogICBpMzg2YmVvcwogICBpMzg2YnNkCiAgIGkzODZnbzMyCiAgIGkzODZseW54
CiAgIGkzODZtb3NzCiAgIGkzODZtc2RvcwogICBpMzg2bnRvCiAgIGkzODZwZQogICBpMzg2
cGVfcG9zaXgKICAgbTMycmVsZgogICBtMzJyZWxmX2xpbnV4CiAgIG0zMnJsZWxmCiAgIG0z
MnJsZWxmX2xpbnV4CiAgIG02OGhjMTFlbGYKICAgbTY4aGMxMWVsZmIKICAgbTY4aGMxMmVs
ZgogICBtNjhoYzEyZWxmYgogICBtNjhrZWxmCiAgIG02OGtlbGZuYnNkCiAgIG05czEyemVs
ZgogICBtY29yZXBlCiAgIG1uMTAyMDAKICAgbW4xMDMwMAogICBtb3hpZWJveAogICBtc3A0
MzBYCiAgIG1zcDQzMGVsZgogICBuZHMzMmJlbGYKICAgbmRzMzJiZWxmMTZtCiAgIG5kczMy
YmVsZl9saW51eAogICBuZHMzMmVsZgogICBuZHMzMmVsZjE2bQogICBuZHMzMmVsZl9saW51
eAogICBuaW9zMmVsZgogICBuaW9zMmxpbnV4CiAgIG5zMzJrbmJzZAogICBwYzUzMm1hY2hh
CiAgIHBkcDExCiAgIHBqZWxmCiAgIHBqbGVsZgogICBwcGNtYWNvcwogICBwcnVlbGYKICAg
c2NvcmUzX2VsZgogICBzY29yZTdfZWxmCiAgIHNoCiAgIHNoZWxmCiAgIHNoZWxmX2ZkCiAg
IHNoZWxmX2xpbnV4CiAgIHNoZWxmX25ic2QKICAgc2hlbGZfbnRvCiAgIHNoZWxmX3VjbGlu
dXgKICAgc2hlbGZfdnh3b3JrcwogICBzaGwKICAgc2hsZWxmCiAgIHNobGVsZl9mZAogICBz
aGxlbGZfbGludXgKICAgc2hsZWxmX25ic2QKICAgc2hsZWxmX250bwogICBzaGxlbGZfdnh3
b3JrcwogICBzaHBlCiAgIHRpYzMwY29mZgogICB0aWMzeGNvZmYKICAgdGljM3hjb2ZmX29u
Y2hpcAogICB0aWM0eGNvZmYKICAgdGljNTR4Y29mZgogICB2ODUwCiAgIHY4NTBfcmg4NTAK
ICAgdmFuaWxsYQogICB2YXhuYnNkCiAgIHhnYXRlZWxmCiAgIHo4MAogICB6ODAwMQogICB6
ODAwMgogICBhYXJjaDY0Y2xvdWRhYmkKICAgYWFyY2g2NGNsb3VkYWJpYgogICBhYXJjaDY0
ZWxmCiAgIGFhcmNoNjRlbGYzMgogICBhYXJjaDY0ZWxmMzJiCiAgIGFhcmNoNjRlbGZiCiAg
IGFhcmNoNjRmYnNkCiAgIGFhcmNoNjRmYnNkYgogICBhYXJjaDY0aGFpa3UKICAgYWFyY2g2
NGxpbnV4CiAgIGFhcmNoNjRsaW51eDMyCiAgIGFhcmNoNjRsaW51eDMyYgogICBhYXJjaDY0
bGludXhiCiAgIGFhcmNoNjRwZQogICBlbGYzMl94ODZfNjQKICAgZWxmMzJiNDMwMAogICBl
bGYzMmJtaXAKICAgZWxmMzJibWlwbjMyCiAgIGVsZjMyYnJpc2N2CiAgIGVsZjMyYnJpc2N2
X2lscDMyCiAgIGVsZjMyYnJpc2N2X2lscDMyZgogICBlbGYzMmJzbWlwCiAgIGVsZjMyYnRz
bWlwCiAgIGVsZjMyYnRzbWlwX2Zic2QKICAgZWxmMzJidHNtaXBuMzIKICAgZWxmMzJidHNt
aXBuMzJfZmJzZAogICBlbGYzMmVibWlwCiAgIGVsZjMyZWJtaXB2eHdvcmtzCiAgIGVsZjMy
ZWxtaXAKICAgZWxmMzJlbG1pcHZ4d29ya3MKICAgZWxmMzJsNDMwMAogICBlbGYzMmxtaXAK
ICAgZWxmMzJsb29uZ2FyY2gKICAgZWxmMzJscjU5MDAKICAgZWxmMzJscjU5MDBuMzIKICAg
ZWxmMzJscmlzY3YKICAgZWxmMzJscmlzY3ZfaWxwMzIKICAgZWxmMzJscmlzY3ZfaWxwMzJm
CiAgIGVsZjMybHNtaXAKICAgZWxmMzJsdHNtaXAKICAgZWxmMzJsdHNtaXBfZmJzZAogICBl
bGYzMmx0c21pcG4zMgogICBlbGYzMmx0c21pcG4zMl9mYnNkCiAgIGVsZjMybWlwc3dpbmRp
c3MKICAgZWxmNjRfYWl4CiAgIGVsZjY0X2lhNjQKICAgZWxmNjRfaWE2NF9mYnNkCiAgIGVs
ZjY0X2lhNjRfdm1zCiAgIGVsZjY0X3MzOTAKICAgZWxmNjRfc3BhcmMKICAgZWxmNjRfc3Bh
cmNfZmJzZAogICBlbGY2NF9zcGFyY19zb2wyCiAgIGVsZjY0YWxwaGEKICAgZWxmNjRhbHBo
YV9mYnNkCiAgIGVsZjY0YWxwaGFfbmJzZAogICBlbGY2NGJtaXAKICAgZWxmNjRicGYKICAg
ZWxmNjRicmlzY3YKICAgZWxmNjRicmlzY3ZfbHA2NAogICBlbGY2NGJyaXNjdl9scDY0Zgog
ICBlbGY2NGJ0c21pcAogICBlbGY2NGJ0c21pcF9mYnNkCiAgIGVsZjY0aHBwYQogICBlbGY2
NGxvb25nYXJjaAogICBlbGY2NGxwcGMKICAgZWxmNjRscHBjX2Zic2QKICAgZWxmNjRscmlz
Y3YKICAgZWxmNjRscmlzY3ZfbHA2NAogICBlbGY2NGxyaXNjdl9scDY0ZgogICBlbGY2NGx0
c21pcAogICBlbGY2NGx0c21pcF9mYnNkCiAgIGVsZjY0bW1peAogICBlbGY2NHBwYwogICBl
bGY2NHBwY19mYnNkCiAgIGVsZjY0cmRvcwogICBlbGY2NHRpbGVneAogICBlbGY2NHRpbGVn
eF9iZQogICBlbGZfbWlwc2VsX2hhaWt1CiAgIGVsZl94ODZfNjQKICAgZWxmX3g4Nl82NF9j
bG91ZGFiaQogICBlbGZfeDg2XzY0X2Zic2QKICAgZWxmX3g4Nl82NF9oYWlrdQogICBlbGZf
eDg2XzY0X3NvbDIKICAgaHBwYTY0bGludXgKICAgaTM4NnBlcAogICBtbW8KCmFsZXhlaUBB
c3BpcmU6fiQgc3VkbyBsc21vZApNb2R1bGUgICAgICAgICAgICAgICAgICBTaXplICBVc2Vk
IGJ5CmNjbSAgICAgICAgICAgICAgICAgICAgMjA0ODAgIDMKYm5lcCAgICAgICAgICAgICAg
ICAgICAyODY3MiAgMgp4dF9DSEVDS1NVTSAgICAgICAgICAgIDE2Mzg0ICAxCnh0X01BU1FV
RVJBREUgICAgICAgICAgMjA0ODAgIDMKeHRfY29ubnRyYWNrICAgICAgICAgICAxNjM4NCAg
MQppcHRfUkVKRUNUICAgICAgICAgICAgIDE2Mzg0ICAyCm5mX3JlamVjdF9pcHY0ICAgICAg
ICAgMTYzODQgIDEgaXB0X1JFSkVDVAp4dF90Y3B1ZHAgICAgICAgICAgICAgIDIwNDgwICA5
CmlwNnRhYmxlX21hbmdsZSAgICAgICAgMTYzODQgIDEKaXA2dGFibGVfbmF0ICAgICAgICAg
ICAxNjM4NCAgMQppcHRhYmxlX21hbmdsZSAgICAgICAgIDE2Mzg0ICAxCmlwdGFibGVfbmF0
ICAgICAgICAgICAgMTYzODQgIDEKbmZfbmF0ICAgICAgICAgICAgICAgICA0OTE1MiAgMyBp
cDZ0YWJsZV9uYXQsaXB0YWJsZV9uYXQseHRfTUFTUVVFUkFERQpuZl9jb25udHJhY2sgICAg
ICAgICAgMTcyMDMyICAzIHh0X2Nvbm50cmFjayxuZl9uYXQseHRfTUFTUVVFUkFERQpuZl9k
ZWZyYWdfaXB2NiAgICAgICAgIDI0NTc2ICAxIG5mX2Nvbm50cmFjawpuZl9kZWZyYWdfaXB2
NCAgICAgICAgIDE2Mzg0ICAxIG5mX2Nvbm50cmFjawpuZl90YWJsZXMgICAgICAgICAgICAg
MjQ5ODU2ICAwCm5mbmV0bGluayAgICAgICAgICAgICAgMjA0ODAgIDEgbmZfdGFibGVzCmlw
NnRhYmxlX2ZpbHRlciAgICAgICAgMTYzODQgIDEKaXA2X3RhYmxlcyAgICAgICAgICAgICAz
Mjc2OCAgMyBpcDZ0YWJsZV9maWx0ZXIsaXA2dGFibGVfbmF0LGlwNnRhYmxlX21hbmdsZQpp
cHRhYmxlX2ZpbHRlciAgICAgICAgIDE2Mzg0ICAxCmJwZmlsdGVyICAgICAgICAgICAgICAg
MTYzODQgIDAKYnJpZGdlICAgICAgICAgICAgICAgIDMwNzIwMCAgMApzdHAgICAgICAgICAg
ICAgICAgICAgIDE2Mzg0ICAxIGJyaWRnZQpsbGMgICAgICAgICAgICAgICAgICAgIDE2Mzg0
ICAyIGJyaWRnZSxzdHAKbmxzX2lzbzg4NTlfMSAgICAgICAgICAxNjM4NCAgMQpubHNfY3A4
NjYgICAgICAgICAgICAgIDIwNDgwICAxCnNuZF9oZGFfY29kZWNfaGRtaSAgICAgNzc4MjQg
IDEKc25kX2hkYV9jb2RlY19yZWFsdGVrICAgMTU1NjQ4ICAxCnNuZF9oZGFfY29kZWNfZ2Vu
ZXJpYyAgIDEwMjQwMCAgMSBzbmRfaGRhX2NvZGVjX3JlYWx0ZWsKdXZjdmlkZW8gICAgICAg
ICAgICAgIDEwNjQ5NiAgMAppbnRlbF9yYXBsX21zciAgICAgICAgIDIwNDgwICAwCnZpZGVv
YnVmMl92bWFsbG9jICAgICAgMjA0ODAgIDEgdXZjdmlkZW8KbGVkdHJpZ19hdWRpbyAgICAg
ICAgICAxNjM4NCAgMSBzbmRfaGRhX2NvZGVjX2dlbmVyaWMKdmlkZW9idWYyX21lbW9wcyAg
ICAgICAyMDQ4MCAgMSB2aWRlb2J1ZjJfdm1hbGxvYwp2aWRlb2J1ZjJfdjRsMiAgICAgICAg
IDMyNzY4ICAxIHV2Y3ZpZGVvCnZpZGVvYnVmMl9jb21tb24gICAgICAgNzc4MjQgIDQgdmlk
ZW9idWYyX3ZtYWxsb2MsdmlkZW9idWYyX3Y0bDIsdXZjdmlkZW8sdmlkZW9idWYyX21lbW9w
cwp2aWRlb2RldiAgICAgICAgICAgICAgMjUzOTUyICAzIHZpZGVvYnVmMl92NGwyLHV2Y3Zp
ZGVvLHZpZGVvYnVmMl9jb21tb24Kc25kX2hkYV9pbnRlbCAgICAgICAgICA1MzI0OCAgNQpt
ZWlfaGRjcCAgICAgICAgICAgICAgIDI0NTc2ICAwCmludGVsX3JhcGxfY29tbW9uICAgICAg
NDA5NjAgIDEgaW50ZWxfcmFwbF9tc3IKaW50ZWxfcG93ZXJjbGFtcCAgICAgICAyMDQ4MCAg
MApydHN4X3VzYl9tcyAgICAgICAgICAgIDI0NTc2ICAwCnNuZF9pbnRlbF9kc3BjZmcgICAg
ICAgMjg2NzIgIDEgc25kX2hkYV9pbnRlbApjb3JldGVtcCAgICAgICAgICAgICAgIDI0NTc2
ICAwCm1lbXN0aWNrICAgICAgICAgICAgICAgMjQ1NzYgIDEgcnRzeF91c2JfbXMKc25kX2lu
dGVsX3Nkd19hY3BpICAgICAyMDQ4MCAgMSBzbmRfaW50ZWxfZHNwY2ZnCm1jICAgICAgICAg
ICAgICAgICAgICAgNjE0NDAgIDQgdmlkZW9kZXYsdmlkZW9idWYyX3Y0bDIsdXZjdmlkZW8s
dmlkZW9idWYyX2NvbW1vbgpzbmRfaGRhX2NvZGVjICAgICAgICAgMTYzODQwICA0IHNuZF9o
ZGFfY29kZWNfZ2VuZXJpYyxzbmRfaGRhX2NvZGVjX2hkbWksc25kX2hkYV9pbnRlbCxzbmRf
aGRhX2NvZGVjX3JlYWx0ZWsKc25kX2hkYV9jb3JlICAgICAgICAgIDExMDU5MiAgNSBzbmRf
aGRhX2NvZGVjX2dlbmVyaWMsc25kX2hkYV9jb2RlY19oZG1pLHNuZF9oZGFfaW50ZWwsc25k
X2hkYV9jb2RlYyxzbmRfaGRhX2NvZGVjX3JlYWx0ZWsKYXRoOWsgICAgICAgICAgICAgICAg
IDIxMjk5MiAgMAphdGgzayAgICAgICAgICAgICAgICAgIDI0NTc2ICAwCmJ0dXNiICAgICAg
ICAgICAgICAgICAgNjE0NDAgIDAKYnRydGwgICAgICAgICAgICAgICAgICAyNDU3NiAgMSBi
dHVzYgprdm1faW50ZWwgICAgICAgICAgICAgMzc2ODMyICAwCnNuZF9od2RlcCAgICAgICAg
ICAgICAgMTYzODQgIDEgc25kX2hkYV9jb2RlYwphdGg5a19jb21tb24gICAgICAgICAgIDQ1
MDU2ICAxIGF0aDlrCnNuZF9wY20gICAgICAgICAgICAgICAxMzUxNjggIDUgc25kX2hkYV9j
b2RlY19oZG1pLHNuZF9oZGFfaW50ZWwsc25kX2hkYV9jb2RlYyxzbmRfaGRhX2NvcmUKa3Zt
ICAgICAgICAgICAgICAgICAgMTAxMTcxMiAgMSBrdm1faW50ZWwKYnRiY20gICAgICAgICAg
ICAgICAgICAyNDU3NiAgMSBidHVzYgpidGludGVsICAgICAgICAgICAgICAgIDQwOTYwICAx
IGJ0dXNiCmF0aDlrX2h3ICAgICAgICAgICAgICA1OTM5MjAgIDIgYXRoOWtfY29tbW9uLGF0
aDlrCmJsdWV0b290aCAgICAgICAgICAgICA2ODgxMjggIDEyIGJ0cnRsLGJ0aW50ZWwsYnRi
Y20sYm5lcCxhdGgzayxidHVzYgpwdW5pdF9hdG9tX2RlYnVnICAgICAgIDE2Mzg0ICAwCnNu
ZF9zZXFfbWlkaSAgICAgICAgICAgMjA0ODAgIDAKaW50ZWxfY3N0YXRlICAgICAgICAgICAy
MDQ4MCAgMApqb3lkZXYgICAgICAgICAgICAgICAgIDMyNzY4ICAwCmlucHV0X2xlZHMgICAg
ICAgICAgICAgMTYzODQgIDAKYWNlcl93bWkgICAgICAgICAgICAgICAyODY3MiAgMAplY2Ro
X2dlbmVyaWMgICAgICAgICAgIDE2Mzg0ICAxIGJsdWV0b290aAplY2MgICAgICAgICAgICAg
ICAgICAgIDM2ODY0ICAxIGVjZGhfZ2VuZXJpYwphdGggICAgICAgICAgICAgICAgICAgIDM2
ODY0ICAzIGF0aDlrX2NvbW1vbixhdGg5ayxhdGg5a19odwpzcGFyc2Vfa2V5bWFwICAgICAg
ICAgIDE2Mzg0ICAxIGFjZXJfd21pCnNlcmlvX3JhdyAgICAgICAgICAgICAgMjA0ODAgIDAK
bWFjODAyMTEgICAgICAgICAgICAgMTI0OTI4MCAgMSBhdGg5awpzbmRfc2VxX21pZGlfZXZl
bnQgICAgIDE2Mzg0ICAxIHNuZF9zZXFfbWlkaQp3bWlfYm1vZiAgICAgICAgICAgICAgIDE2
Mzg0ICAwCmhpZF9tdWx0aXRvdWNoICAgICAgICAgMzI3NjggIDAKc25kX3Jhd21pZGkgICAg
ICAgICAgICA0OTE1MiAgMSBzbmRfc2VxX21pZGkKYXQyNCAgICAgICAgICAgICAgICAgICAy
NDU3NiAgMApjZmc4MDIxMSAgICAgICAgICAgICAgOTcwNzUyICA0IGF0aDlrX2NvbW1vbixh
dGg5ayxhdGgsbWFjODAyMTEKaW50ZWxfeGhjaV91c2Jfcm9sZV9zd2l0Y2ggICAgMTYzODQg
IDAKc25kX3NlcSAgICAgICAgICAgICAgICA3NzgyNCAgMiBzbmRfc2VxX21pZGksc25kX3Nl
cV9taWRpX2V2ZW50CnNuZF9zZXFfZGV2aWNlICAgICAgICAgMTYzODQgIDMgc25kX3NlcSxz
bmRfc2VxX21pZGksc25kX3Jhd21pZGkKbGliYXJjNCAgICAgICAgICAgICAgICAxNjM4NCAg
MSBtYWM4MDIxMQpzbmRfdGltZXIgICAgICAgICAgICAgIDQwOTYwICAyIHNuZF9zZXEsc25k
X3BjbQpzbmQgICAgICAgICAgICAgICAgICAgMTAyNDAwICAyMCBzbmRfaGRhX2NvZGVjX2dl
bmVyaWMsc25kX3NlcSxzbmRfc2VxX2RldmljZSxzbmRfaGRhX2NvZGVjX2hkbWksc25kX2h3
ZGVwLHNuZF9oZGFfaW50ZWwsc25kX2hkYV9jb2RlYyxzbmRfaGRhX2NvZGVjX3JlYWx0ZWss
c25kX3RpbWVyLHNuZF9wY20sc25kX3Jhd21pZGkKbWFjX2hpZCAgICAgICAgICAgICAgICAx
NjM4NCAgMApzb3VuZGNvcmUgICAgICAgICAgICAgIDE2Mzg0ICAxIHNuZAptZWlfdHhlICAg
ICAgICAgICAgICAgIDI4NjcyICAxCm1laSAgICAgICAgICAgICAgICAgICAxMzUxNjggIDMg
bWVpX2hkY3AsbWVpX3R4ZQppbnRlbF9pbnQwMDAyX3ZncGlvICAgIDE2Mzg0ICAxCnNjaF9m
cV9jb2RlbCAgICAgICAgICAgMjQ1NzYgIDMKbXNyICAgICAgICAgICAgICAgICAgICAxNjM4
NCAgMApwYXJwb3J0X3BjICAgICAgICAgICAgIDUzMjQ4ICAwCnBwZGV2ICAgICAgICAgICAg
ICAgICAgMjQ1NzYgIDAKbHAgICAgICAgICAgICAgICAgICAgICAyODY3MiAgMApwYXJwb3J0
ICAgICAgICAgICAgICAgIDY5NjMyICAzIHBhcnBvcnRfcGMsbHAscHBkZXYKYmluZGVyX2xp
bnV4ICAgICAgICAgIDIwODg5NiAgMAphc2htZW1fbGludXggICAgICAgICAgIDIwNDgwICAw
CmlwX3RhYmxlcyAgICAgICAgICAgICAgMzI3NjggIDMgaXB0YWJsZV9maWx0ZXIsaXB0YWJs
ZV9uYXQsaXB0YWJsZV9tYW5nbGUKeF90YWJsZXMgICAgICAgICAgICAgICA1MzI0OCAgMTMg
aXA2dGFibGVfZmlsdGVyLHh0X2Nvbm50cmFjayxpcHRhYmxlX2ZpbHRlcixpcDZ0YWJsZV9u
YXQseHRfdGNwdWRwLHh0X0NIRUNLU1VNLGlwNl90YWJsZXMsaXB0X1JFSkVDVCxpcF90YWJs
ZXMsaXB0YWJsZV9uYXQsaXA2dGFibGVfbWFuZ2xlLHh0X01BU1FVRVJBREUsaXB0YWJsZV9t
YW5nbGUKYXV0b2ZzNCAgICAgICAgICAgICAgICA0OTE1MiAgMgpidHJmcyAgICAgICAgICAg
ICAgICAxNTM2MDAwICA1CmJsYWtlMmJfZ2VuZXJpYyAgICAgICAgMjA0ODAgIDAKeG9yICAg
ICAgICAgICAgICAgICAgICAyNDU3NiAgMSBidHJmcwp6c3RkX2NvbXByZXNzICAgICAgICAg
MjI1MjgwICAxIGJ0cmZzCnJhaWQ2X3BxICAgICAgICAgICAgICAxMjI4ODAgIDEgYnRyZnMK
bGliY3JjMzJjICAgICAgICAgICAgICAxNjM4NCAgNCBuZl9jb25udHJhY2ssbmZfbmF0LGJ0
cmZzLG5mX3RhYmxlcwpkbV9taXJyb3IgICAgICAgICAgICAgIDI0NTc2ICAwCmRtX3JlZ2lv
bl9oYXNoICAgICAgICAgMjQ1NzYgIDEgZG1fbWlycm9yCmRtX2xvZyAgICAgICAgICAgICAg
ICAgMjA0ODAgIDIgZG1fcmVnaW9uX2hhc2gsZG1fbWlycm9yCnJ0c3hfdXNiX3NkbW1jICAg
ICAgICAgMzY4NjQgIDAKcnRzeF91c2IgICAgICAgICAgICAgICAyODY3MiAgMiBydHN4X3Vz
Yl9zZG1tYyxydHN4X3VzYl9tcwp1c2JoaWQgICAgICAgICAgICAgICAgIDY1NTM2ICAwCmk5
MTUgICAgICAgICAgICAgICAgIDMwNTk3MTIgIDM0CmkyY19hbGdvX2JpdCAgICAgICAgICAg
MTYzODQgIDEgaTkxNQp0dG0gICAgICAgICAgICAgICAgICAgIDg2MDE2ICAxIGk5MTUKZHJt
X2ttc19oZWxwZXIgICAgICAgIDMwNzIwMCAgMSBpOTE1CnN5c2NvcHlhcmVhICAgICAgICAg
ICAgMTYzODQgIDEgZHJtX2ttc19oZWxwZXIKc3lzZmlsbHJlY3QgICAgICAgICAgICAyMDQ4
MCAgMSBkcm1fa21zX2hlbHBlcgpzeXNpbWdibHQgICAgICAgICAgICAgIDE2Mzg0ICAxIGRy
bV9rbXNfaGVscGVyCmZiX3N5c19mb3BzICAgICAgICAgICAgMTYzODQgIDEgZHJtX2ttc19o
ZWxwZXIKY2VjICAgICAgICAgICAgICAgICAgICA2MTQ0MCAgMiBkcm1fa21zX2hlbHBlcixp
OTE1CmhpZF9nZW5lcmljICAgICAgICAgICAgMTYzODQgIDAKcmNfY29yZSAgICAgICAgICAg
ICAgICA2MTQ0MCAgMSBjZWMKY3JjdDEwZGlmX3BjbG11bCAgICAgICAxNjM4NCAgMQpjcmMz
Ml9wY2xtdWwgICAgICAgICAgIDE2Mzg0ICAwCmdoYXNoX2NsbXVsbmlfaW50ZWwgICAgMTYz
ODQgIDAKaTJjX2k4MDEgICAgICAgICAgICAgICAzNjg2NCAgMApkcm0gICAgICAgICAgICAg
ICAgICAgNjE4NDk2ICA5IGRybV9rbXNfaGVscGVyLGk5MTUsdHRtCmkyY19oaWRfYWNwaSAg
ICAgICAgICAgMTYzODQgIDAKYWVzbmlfaW50ZWwgICAgICAgICAgIDM3NjgzMiAgMgppMmNf
aGlkICAgICAgICAgICAgICAgIDM2ODY0ICAxIGkyY19oaWRfYWNwaQphaGNpICAgICAgICAg
ICAgICAgICAgIDQ1MDU2ICAxMApjcnlwdG9fc2ltZCAgICAgICAgICAgIDE2Mzg0ICAxIGFl
c25pX2ludGVsCmNyeXB0ZCAgICAgICAgICAgICAgICAgMjQ1NzYgIDIgY3J5cHRvX3NpbWQs
Z2hhc2hfY2xtdWxuaV9pbnRlbApyODE2OSAgICAgICAgICAgICAgICAgIDg2MDE2ICAwCmR3
X2RtYWMgICAgICAgICAgICAgICAgMTYzODQgIDAKeGhjaV9wY2kgICAgICAgICAgICAgICAy
NDU3NiAgMApsaWJhaGNpICAgICAgICAgICAgICAgIDQ1MDU2ICAxIGFoY2kKaGlkICAgICAg
ICAgICAgICAgICAgIDE0NzQ1NiAgNCBpMmNfaGlkLHVzYmhpZCxoaWRfbXVsdGl0b3VjaCxo
aWRfZ2VuZXJpYwpyZWFsdGVrICAgICAgICAgICAgICAgIDMyNzY4ICAxCmxwY19pY2ggICAg
ICAgICAgICAgICAgMjg2NzIgIDAKeGhjaV9wY2lfcmVuZXNhcyAgICAgICAyMDQ4MCAgMSB4
aGNpX3BjaQppMmNfc21idXMgICAgICAgICAgICAgIDIwNDgwICAxIGkyY19pODAxCmR3X2Rt
YWNfY29yZSAgICAgICAgICAgMzY4NjQgIDEgZHdfZG1hYwp3bWkgICAgICAgICAgICAgICAg
ICAgIDMyNzY4ICAyIGFjZXJfd21pLHdtaV9ibW9mCnZpZGVvICAgICAgICAgICAgICAgICAg
NTczNDQgIDIgYWNlcl93bWksaTkxNQoKYWxleGVpQEFzcGlyZTp+JCBsc2NwdQrQkNGA0YXQ
uNGC0LXQutGC0YPRgNCwOiAgICAgICAgICAgICAgICAgICAgIHg4Nl82NApDUFUgb3AtbW9k
ZShzKTogICAgICAgICAgICAgICAgICAzMi1iaXQsIDY0LWJpdArQn9C+0YDRj9C00L7QuiDQ
sdCw0LnRgjogICAgICAgICAgICAgICAgICAgIExpdHRsZSBFbmRpYW4KQWRkcmVzcyBzaXpl
czogICAgICAgICAgICAgICAgICAgMzYgYml0cyBwaHlzaWNhbCwgNDggYml0cyB2aXJ0dWFs
CkNQVShzKTogICAgICAgICAgICAgICAgICAgICAgICAgIDQKT24tbGluZSBDUFUocykgbGlz
dDogICAgICAgICAgICAgMC0zCtCf0L7RgtC+0LrQvtCyINC90LAg0Y/QtNGA0L46ICAgICAg
ICAgICAgICAgICAxCtCv0LTQtdGAINC90LAg0YHQvtC60LXRgjogICAgICAgICAgICAgICAg
ICAgNArQodC+0LrQtdGC0L7QsjogICAgICAgICAgICAgICAgICAgICAgICAgMQpOVU1BIG5v
ZGUocyk6ICAgICAgICAgICAgICAgICAgICAxCklEINC/0YDRgNC+0LjQt9Cy0L7QtNC40YLQ
tdC70Y86ICAgICAgICAgICAgICAgR2VudWluZUludGVsCtCh0LXQvNC10LnRgdGC0LLQviDQ
ptCf0KM6ICAgICAgICAgICAgICAgICAgIDYK0JzQvtC00LXQu9GMOiAgICAgICAgICAgICAg
ICAgICAgICAgICAgNzYK0JjQvNGPINC80L7QtNC10LvQuDogICAgICAgICAgICAgICAgICAg
ICAgSW50ZWwoUikgUGVudGl1bShSKSBDUFUgIE4zNzAwICBAIDEuNjBHSHoK0KHRgtC10L/Q
v9C40L3QszogICAgICAgICAgICAgICAgICAgICAgICAzCkNQVSDQnNCT0YY6ICAgICAgICAg
ICAgICAgICAgICAgICAgIDE2MzAuMTQxCkNQVSBtYXggTUh6OiAgICAgICAgICAgICAgICAg
ICAgIDI0MDAsMDAwMApDUFUgbWluIE1IejogICAgICAgICAgICAgICAgICAgICA0ODAsMDAw
MApCb2dvTUlQUzogICAgICAgICAgICAgICAgICAgICAgICAzMjAwLjAwCtCS0LjRgNGC0YPQ
sNC70LjQt9Cw0YbQuNGPOiAgICAgICAgICAgICAgICAgICBWVC14CkwxZCBjYWNoZTogICAg
ICAgICAgICAgICAgICAgICAgIDk2IEtpQgpMMWkgY2FjaGU6ICAgICAgICAgICAgICAgICAg
ICAgICAxMjggS2lCCkwyIGNhY2hlOiAgICAgICAgICAgICAgICAgICAgICAgIDIgTWlCCk5V
TUEgbm9kZTAgQ1BVKHMpOiAgICAgICAgICAgICAgIDAtMwpWdWxuZXJhYmlsaXR5IEl0bGIg
bXVsdGloaXQ6ICAgICBOb3QgYWZmZWN0ZWQKVnVsbmVyYWJpbGl0eSBMMXRmOiAgICAgICAg
ICAgICAgTm90IGFmZmVjdGVkClZ1bG5lcmFiaWxpdHkgTWRzOiAgICAgICAgICAgICAgIE1p
dGlnYXRpb247IENsZWFyIENQVSBidWZmZXJzOyBTTVQgZGlzYWJsZWQKVnVsbmVyYWJpbGl0
eSBNZWx0ZG93bjogICAgICAgICAgTWl0aWdhdGlvbjsgUFRJClZ1bG5lcmFiaWxpdHkgTW1p
byBzdGFsZSBkYXRhOiAgIFVua25vd246IE5vIG1pdGlnYXRpb25zClZ1bG5lcmFiaWxpdHkg
UmV0YmxlZWQ6ICAgICAgICAgIE5vdCBhZmZlY3RlZApWdWxuZXJhYmlsaXR5IFNwZWMgc3Rv
cmUgYnlwYXNzOiBOb3QgYWZmZWN0ZWQKVnVsbmVyYWJpbGl0eSBTcGVjdHJlIHYxOiAgICAg
ICAgTWl0aWdhdGlvbjsgdXNlcmNvcHkvc3dhcGdzIGJhcnJpZXJzIGFuZCBfX3VzZXIgcG9p
bnRlciBzYW5pdGl6YXQKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW9uClZ1
bG5lcmFiaWxpdHkgU3BlY3RyZSB2MjogICAgICAgIE1pdGlnYXRpb247IFJldHBvbGluZXMs
IElCUEIgY29uZGl0aW9uYWwsIElCUlNfRlcsIFNUSUJQIGRpc2FibGVkCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICwgUlNCIGZpbGxpbmcsIFBCUlNCLWVJQlJTIE5vdCBh
ZmZlY3RlZApWdWxuZXJhYmlsaXR5IFNyYmRzOiAgICAgICAgICAgICBOb3QgYWZmZWN0ZWQK
VnVsbmVyYWJpbGl0eSBUc3ggYXN5bmMgYWJvcnQ6ICAgTm90IGFmZmVjdGVkCtCk0LvQsNCz
0Lg6ICAgICAgICAgICAgICAgICAgICAgICAgICAgZnB1IHZtZSBkZSBwc2UgdHNjIG1zciBw
YWUgbWNlIGN4OCBhcGljIHNlcCBtdHJyIHBnZSBtY2EgY21vdiBwYXQKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHBzZTM2IGNsZmx1c2ggZHRzIGFjcGkgbW14IGZ4c3Ig
c3NlIHNzZTIgc3MgaHQgdG0gcGJlIHN5c2NhbGwgbngKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJkdHNjcCBsbSBjb25zdGFudF90c2MgYXJjaF9wZXJmbW9uIHBlYnMg
YnRzIHJlcF9nb29kIG5vcGwgeHRvcG8KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbG9neSB0c2NfcmVsaWFibGUgbm9uc3RvcF90c2MgY3B1aWQgYXBlcmZtcGVyZiB0c2Nf
a25vd25fZnJlcSBwbmkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBjbG11
bHFkcSBkdGVzNjQgbW9uaXRvciBkc19jcGwgdm14IGVzdCB0bTIgc3NzZTMgY3gxNiB4dHBy
IHBkY20KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNzZTRfMSBzc2U0XzIg
bW92YmUgcG9wY250IHRzY19kZWFkbGluZV90aW1lciBhZXMgcmRyYW5kIGxhaGZfbG0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDNkbm93cHJlZmV0Y2ggZXBiIHB0aSBp
YnJzIGlicGIgc3RpYnAgdHByX3NoYWRvdyB2bm1pIGZsZXhwcmlvcmkKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdHkgZXB0IHZwaWQgdHNjX2FkanVzdCBzbWVwIGVybXMg
ZHRoZXJtIGlkYSBhcmF0IG1kX2NsZWFyCgoKIyBodHRwczovL2xvc3N0LnByby9zYm9yLWlu
Zm9ybWF0c2lpLW8tc2lzdGVtZS11YnVudHUjMjlfJUQwJTk3JUQwJUIwJUQwJUIzJUQxJTgw
JUQxJTgzJUQwJUI2JUQwJUI1JUQwJUJEJUQwJUJEJUQxJThCJUQwJUI1XyVEMCVCQyVEMCVC
RSVEMCVCNCVEMSU4MyVEMCVCQiVEMCVCOF8lRDElOEYlRDAlQjQlRDElODAlRDAlQjAK

--------------YRxpbhoRI0ad0ue0ttEFfsYv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------YRxpbhoRI0ad0ue0ttEFfsYv--
