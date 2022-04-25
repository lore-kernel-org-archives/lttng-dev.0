Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CF7C433FE
	for <lttng-dev@archiver.kernel.org>; Mon, 25 Apr 2022 13:29:28 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Kn5TL3w3PzCvt;
	Mon, 25 Apr 2022 09:29:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1650893367;
	bh=wAjxzpHTYANGh3OTzQedwOEF21s8PQ84JKms6i23pgg=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=CAwmJGYySM9WJmPs4G6Q/6sD1QYmcEe1ZmJtYb2x/OFGjMZcagMsFhwVcLfTqalwx
	 v+RZhrG2GQC9I57J7O/vv1H68y9vmVHVJh/VuVahsdn5p1vYhvxWp85ySys2auCdYq
	 mKRT6EgCagJxrsvt+6dAoig9NDBJu9gCjK839WjaH5WmZPqGwmm+h0qQiG+nkYQcDk
	 4ySd/mYW2t8aOxtIXRzZRgKcfpBt+/Box4G8iRhk/ruMCf8PLzOm9uWi3wmytazYZI
	 9/DHP8oJUrY7KFLtB27rNDrrHP1mBtGA8GH6D9eGTl3otVv7GSwJENtwfbJGwdn3hr
	 TbgkaqU2Tb4gw==
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Kn5TK10hkzCyy
 for <lttng-dev@lists.lttng.org>; Mon, 25 Apr 2022 09:29:25 -0400 (EDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-_aaUghnCOlGqJ792-Aw9pw-1; Mon, 25 Apr 2022 09:28:07 -0400
X-MC-Unique: _aaUghnCOlGqJ792-Aw9pw-1
Received: by mail-wr1-f72.google.com with SMTP id
 t17-20020adfa2d1000000b0020ac519c222so2284067wra.4
 for <lttng-dev@lists.lttng.org>; Mon, 25 Apr 2022 06:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=1zia9ZkLNn3Uw1gbiJ05wW12+mUK9KGbre/JX1TEYww=;
 b=ESCB0E1KgrKiEyWnyqlWqThX6qroexpyDnlrCPOGM5KCULnVF530VOqKlEgZs6RA/L
 8ftOhmAxHZzSAt/HiEYmxq034jnH+Ug2Nmnjj+Q4ox9+2a46RS+T8joeKaVXKF+OQ3fp
 zD6b1ld/r7I+pzJNC4VUFCbsd7XJuxsqxYRCvpzuwQuK8uNieHC8Kmxh3O2SDux5rHPo
 T35kmnlTvcZ3LNA7fAgBsaFpcDGp3xkGSfLj47Ej/zKMKhkadDoAnQ6HuJbkpW63QqgP
 d4ikGy4PJMi6SmGko71HMgdrLia8UmxU/OQPreQrvvCnqSXkZ/eW7yHakVaC1un4Atg2
 8YEQ==
X-Gm-Message-State: AOAM531/rIWyIj3Z149K9v+H8yER8K21Jt8ehS4Z5W44xktBJLGwyyR6
 FXPjHYgZRgVEjI7GibWqK/T5fhkC4h4RQJMZQp/yMS1q950XpteitFT+OIEW8Dz5DvlOKbKKF8s
 K6eZrMXw9FqFhEQC5LNhU
X-Received: by 2002:a5d:59a5:0:b0:20a:da19:32cf with SMTP id
 p5-20020a5d59a5000000b0020ada1932cfmr4802853wrr.147.1650893286688; 
 Mon, 25 Apr 2022 06:28:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybpiyw2AUDdzK8eie5iFirsBO1OK+mtnmEkz7wJ78OukDW7WDIUwz2HH/Vs/rM20leeO9fkQ==
X-Received: by 2002:a5d:59a5:0:b0:20a:da19:32cf with SMTP id
 p5-20020a5d59a5000000b0020ada1932cfmr4802842wrr.147.1650893286448; 
 Mon, 25 Apr 2022 06:28:06 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:e3ec:5559:7c5c:1928?
 ([2001:b07:6468:f312:e3ec:5559:7c5c:1928])
 by smtp.googlemail.com with ESMTPSA id
 c3-20020a05600c148300b0038ebc8ad740sm12622635wmh.1.2022.04.25.06.28.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Apr 2022 06:28:05 -0700 (PDT)
Message-ID: <6f716388-ea25-288a-847e-c602051157b6@redhat.com>
Date: Mon, 25 Apr 2022 15:28:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Sean Christopherson <seanjc@google.com>,
 lttng-dev <lttng-dev@lists.lttng.org>, rostedt <rostedt@goodmis.org>,
 KVM list <kvm@vger.kernel.org>
References: <1218866473.10909.1649432186473.JavaMail.zimbra@efficios.com>
 <3c11308e-006a-a7e9-8482-c6b341690530@redhat.com>
 <1622857974.11247.1649441213797.JavaMail.zimbra@efficios.com>
 <358746537.34457.1650891622938.JavaMail.zimbra@efficios.com>
In-Reply-To: <358746537.34457.1650891622938.JavaMail.zimbra@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Subject: Re: [lttng-dev] Unexport of kvm_x86_ops vs tracer modules
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
From: Paolo Bonzini via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 4/25/22 15:00, Mathieu Desnoyers wrote:
> We are at 5.18-rc4 now. Should I expect this unexport to stay in place
> for 5.18 final and go ahead with using kallsyms to find this symbol from
> lttng-modules instead ?

Yes, I don't think honestly that there's any reason to have the symbols 
in place for out-of-tree modules.  I would have hoped Steven to chime 
in, but this also does not seem to be one of the cases where using 
trace_*_enabled() is the way to go.

Paolo

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
