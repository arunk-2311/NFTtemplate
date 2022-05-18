from brownie import SVGNFT, network
from scripts.helpful_scripts import get_account
import yaml


def deploy_svg_nft():
    print(network.show_active())
    owner = get_account()
    svg_nft_contract = SVGNFT.deploy({"from": owner}, publish_source=True)
    svgImage = collect_svg()
    print(svgImage)
    tx = svg_nft_contract.create(svgImage, {"from": owner})
    print(tx.events['CreatedSVGNFT']['tokenURI'])
    print(svg_nft_contract.address)


def collect_svg():
    with open("img/triangle.svg", "r") as svg:
        load_svg = yaml.load(svg, Loader=yaml.FullLoader)

    return load_svg


def main():
    deploy_svg_nft()
