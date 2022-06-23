import os

import yaml
from traits.api import HasTraits, Str


class AliyunConfig(HasTraits):

    def __init__(self):
        super(AliyunConfig, self).__init__()
        self.oss_access_key_id = Str()
        self.oss_access_key_secret = Str()
        self.oss_endpoint = Str()
        self.oss_bucket = Str()
        self.oss_domain = Str()

    def load_from(self, data: dict):
        oss = data.get("oss", {})
        self.oss_access_key_id = oss.get("access_key_id", "")
        self.oss_access_key_secret = oss.get("access_key_secret", "")
        self.oss_endpoint = oss.get("endpoint", "")
        self.oss_bucket = oss.get("bucket", "")
        self.oss_domain = oss.get("domain", "")


class Config(HasTraits):

    __default_inst: "Config" = None

    def __init__(self):
        super(Config, self).__init__()
        self.aliyun_config = AliyunConfig()

    def load_from(self, data: dict):
        self.aliyun_config.load_from(data.get("aliyun", {}))

    @classmethod
    def default(cls):
        if cls.__default_inst is None:
            cls.__default_inst = Config()
        return cls.__default_inst


def __load_config():
    file_abspath = os.path.abspath(__file__)
    conf_abspath = os.path.join(os.path.dirname(os.path.dirname(file_abspath)), "conf.yml")
    with open(conf_abspath) as f:
        data = yaml.load(f.read(), yaml.SafeLoader)
    config = Config.default()

    config.load_from(data)


__load_config()
